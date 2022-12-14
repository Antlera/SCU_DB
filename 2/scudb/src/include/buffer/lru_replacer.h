/**
 * lru_replacer.h
 *
 * Functionality: The buffer pool manager must maintain a LRU list to collect
 * all the pages that are unpinned and ready to be swapped. The simplest way to
 * implement LRU is a FIFO queue, but remember to dequeue or enqueue pages when
 * a page changes from unpinned to pinned, or vice-versa.
 */

#pragma once

// #include <memory>
#include <unordered_map>
#include <mutex>
#include <list>
#include <algorithm>
#include "buffer/replacer.h"
#include "hash/extendible_hash.h"

namespace scudb
{
  template <typename T>
  class LRUReplacer : public Replacer<T>
  {
  public:
    // do not change public interface
    LRUReplacer();

    ~LRUReplacer();

    void Insert(const T &value);

    bool Victim(T &value);

    bool Erase(const T &value);

    size_t Size();

  private:
    // add your member variables here
    mutable std::mutex latch;                                      // 并发锁
    std::list<T> lruList;                                          // 页面链表
    std::unordered_map<T, typename std::list<T>::iterator> lruMap; // 页面hash表
  };

} // namespace scudb
