#include <list>
#include <cmath>
#include <algorithm>
#include "hash/extendible_hash.h"
#include "page/page.h"

namespace scudb
{

  /*
   * constructor
   * array_size: fixed array size for each bucket
   */
  template <typename K, typename V>
  ExtendibleHash<K, V>::ExtendibleHash(size_t size) : globalDepth(0), bucketFixedSize(size)
  {
    buckets.push_back(std::make_shared<Bucket>(0));
  }
  template <typename K, typename V>
  ExtendibleHash<K, V>::ExtendibleHash() : globalDepth(0), bucketFixedSize(SIZE_MAX)
  {
    buckets.push_back(std::make_shared<Bucket>(0));
  }
  /*
   * helper function to calculate the hashing address of input key
   */
  template <typename K, typename V>
  size_t ExtendibleHash<K, V>::HashKey(const K &key) const
  {
    return std::hash<K>{}(key);
  }
  /*
   * helper function to truncate the low bits of hashing address to be the bucket index
   */
  template <typename K, typename V>
  int ExtendibleHash<K, V>::getBucketIndex(const K &key) const
  {
    std::lock_guard<std::mutex> glck(latch);
    return HashKey(key) & ((1 << globalDepth) - 1);
  }

  /*
   * helper function to return global depth of hash table
   * NOTE: you must implement this function in order to pass test
   */
  template <typename K, typename V>
  int ExtendibleHash<K, V>::GetGlobalDepth() const
  {
    std::lock_guard<std::mutex> glck(latch);
    return globalDepth;
  }

  /*
   * helper function to return local depth of one specific bucket
   * NOTE: you must implement this function in order to pass test
   */
  template <typename K, typename V>
  int ExtendibleHash<K, V>::GetLocalDepth(int bucket_id) const
  {
    if (buckets[bucket_id])
    { // 判断对应id的bucket是否存在
      std::lock_guard<std::mutex> blck(buckets[bucket_id]->bLatch);
      if (buckets[bucket_id]->hashMap.size() == 0)
        return -1;
      else
        return buckets[bucket_id]->localDepth;
    }
    return -1; // 若不存在返回-1
  }

  /*
   * helper function to return current number of bucket in hash table
   */
  template <typename K, typename V>
  int ExtendibleHash<K, V>::GetNumBuckets() const
  {
    std::lock_guard<std::mutex> glck(latch);
    return bucketNum;
  }

  /*
   * lookup function to find value associate with input key
   */
  template <typename K, typename V>
  bool ExtendibleHash<K, V>::Find(const K &key, V &value)
  {
    int bIndex = getBucketIndex(key);
    auto cur = buckets[bIndex];
    std::lock_guard<std::mutex> blck(cur->bLatch);
    if (cur->hashMap.find(key) != cur->hashMap.end())
    {
      value = cur->hashMap[key];
      return true;
    }
    return false;
  }

  /*
   * delete <key,value> entry in hash table
   * Shrink & Combination is not required for this project
   */
  template <typename K, typename V>
  bool ExtendibleHash<K, V>::Remove(const K &key)
  {
    int bIndex = getBucketIndex(key);
    auto cur = buckets[bIndex];
    std::lock_guard<std::mutex> blck(cur->bLatch);
    if (cur->hashMap.find(key) == cur->hashMap.end()) // 不在hash表内无法删除
    {
      return false;
    }
    else
    {
      cur->hashMap.erase(key);
      return true;
    }
  }

  /*
   * insert <key,value> entry in hash table
   * Split & Redistribute bucket when there is overflow and if necessary increase
   * global depth
   */
  template <typename K, typename V>
  void ExtendibleHash<K, V>::Insert(const K &key, const V &value)
  {
    int bIndex = getBucketIndex(key);
    auto cur = buckets[bIndex];
    while (true)
    {
      std::lock_guard<std::mutex> blck(cur->bLatch);
      size_t bucketSize = (size_t)pow(2, (globalDepth - cur->localDepth));
      // std::cout << "std::min(bucketSize, bucketFixedSize)  " << bucketSize << "   " << bucketFixedSize << std::endl;
      if (cur->hashMap.find(key) != cur->hashMap.end())
      {
        cur->hashMap[key] = value;
        break;
      }
      else if (cur->hashMap.size() < std::min(bucketSize, bucketFixedSize))
      // else if (cur->hashMap.size() < bucketFixedSize)
      {
        cur->hashMap[key] = value;
        break;
      }

      int mask = (1 << (cur->localDepth)); // 桶大小不足需要分裂0, 1开头不同的桶
      cur->localDepth++;

      {
        std::lock_guard<std::mutex> glck(latch);
        if (cur->localDepth > globalDepth)
        {

          size_t length = buckets.size();
          for (size_t i = 0; i < length; i++)
          {
            buckets.push_back(buckets[i]);
          }
          globalDepth++;
        }
        bucketNum++;

        auto newBucket = std::make_shared<Bucket>(cur->localDepth);

        for (auto it = cur->hashMap.begin(); it != cur->hashMap.end();)
        {
          if (HashKey(it->first) & mask)
          {
            newBucket->hashMap[it->first] = it->second; //  将localDepth下一位上为0与为1的分开
            it = cur->hashMap.erase(it);
          }
          else
            it++;
        }
        for (size_t i = 0; i < buckets.size(); i++)
        {
          if (buckets[i] == cur && (i & mask))
            buckets[i] = newBucket;
        }
      }
        bIndex = getBucketIndex(key);
        cur = buckets[bIndex]; // 由于globalDepth更新，因此需要重新更新索引位置
    }
  }

  template class ExtendibleHash<page_id_t, Page *>;
  template class ExtendibleHash<Page *, std::list<Page *>::iterator>;
  // test purpose
  template class ExtendibleHash<int, std::string>;
  template class ExtendibleHash<int, std::list<int>::iterator>;
  template class ExtendibleHash<int, int>;
} // namespace scudb
