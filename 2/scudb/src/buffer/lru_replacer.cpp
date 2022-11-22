/**
 * LRU implementation
 */
#include "buffer/lru_replacer.h"
#include "page/page.h"

namespace scudb {

template <typename T> LRUReplacer<T>::LRUReplacer() {}

template <typename T> LRUReplacer<T>::~LRUReplacer() {}

/*
 * Insert value into LRU
 */
template <typename T> void LRUReplacer<T>::Insert(const T &value) {
  std::lock_guard<std::mutex> lck(latch);
  if(lruMap.find(value) != lruMap.end()){
    auto cur = lruMap[value];
    lruList.erase(cur);
  }
  lruList.push_front(value);
  lruMap[value] = lruList.begin();
}

/* If LRU is non-empty, pop the head member from LRU to argument "value", and
 * return true. If LRU is empty, return false
 */
template <typename T> bool LRUReplacer<T>::Victim(T &value) {
  std::lock_guard<std::mutex> lck(latch);
  if(lruList.empty())
    return false;
  value = lruList.back();
  std::cout << "Victim:  " << value << std::endl;
  lruMap.erase(value);
  lruList.pop_back();
  return true;
}

/*
 * Remove value from LRU. If removal is successful, return true, otherwise
 * return false
 */
template <typename T> bool LRUReplacer<T>::Erase(const T &value) {
  std::lock_guard<std::mutex> lck(latch);
  if(lruMap.find(value)!= lruMap.end()){
    auto cur = lruMap[value];
    lruList.erase(cur);
  }
  return lruMap.erase(value);

}

template <typename T> size_t LRUReplacer<T>::Size() { 
  std::lock_guard<std::mutex> lck(latch);
  return lruList.size();
}

template class LRUReplacer<Page *>;
// test only
template class LRUReplacer<int>;

} // namespace scudb
