/*
 * extendible_hash.h : implementation of in-memory hash table using extendible
 * hashing
 *
 * Functionality: The buffer pool manager must maintain a page table to be able
 * to quickly map a PageId to its corresponding memory location; or alternately
 * report that the PageId does not match any currently-buffered page.
 */

#pragma once

#include <cstdlib>
#include <vector>
#include <string>
#include <map>
#include <memory>
#include <mutex>
#include "hash/hash_table.h"


namespace scudb {

template <typename K, typename V>
class ExtendibleHash : public HashTable<K, V> {
public:
  struct Bucket
  {
    Bucket(int depth) : localDepth(depth){};
    int localDepth;
    std::map<K, V> hashMap;// 即实际的h std::atomic requires a trivially copyable typeash表项，在扩容复制时，仍然指向同一个hash表项，因此可以直接复制，直至下一次达到数量限制则会重新扩容，调整两桶的hash表项
    std::mutex bLatch;
  };
  
  // constructor
  ExtendibleHash(size_t size);
  ExtendibleHash();
  // helper function to generate hash addressing
  size_t HashKey(const K &key) const;
  // helper function to get low bits of global depth to be the bucket index which the item should be insert.
  int getBucketIndex(const K &key) const;
  // helper function to get global & local depth
  int GetGlobalDepth() const;
  int GetLocalDepth(int bucket_id) const;
  int GetNumBuckets() const;
  // lookup and modifier
  bool Find(const K &key, V &value) override;
  bool Remove(const K &key) override;
  void Insert(const K &key, const V &value) override;

private:
  // add your own member variables here
  std::vector<std::shared_ptr<Bucket>> buckets;
  int globalDepth;  //  the length of low bits that the ex-hashtable cares about
  const size_t bucketFixedSize;  // the max amount of items one bucket can contain
  int bucketNum; // counts of buckets
  mutable std::mutex latch;
};
} // namespace scudb
