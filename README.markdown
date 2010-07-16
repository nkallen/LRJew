# LRJew is an LRU efficiency simulator.

## For example, to run a set of queries through an LRU with 200,000 slots:

    % cat queries.log | lrjew 200000
    gets	5850000	hits	5027414	misses	822586	evictions	522586	rate	0.859387008547009

## Wait, what is an LRU again?

* A cache is an efficient place to store data.
* If you have a cache of bounded size, and you keep putting more and more data into the cache, eventually your cache will be full.
* When a cache is full, you can either throw away some data or not add new data.
* An LRU is the most popular "cache replacement algorithm".
* An LRU is a policy whereby you make room for new data by throwing away the oldest data.
* You can think of an LRU as a stack of bounded size where the oldest items fall off the bottom.

## Why do I want to know the efficiency of my LRU?

* The efficiency of the cache is the cache hit rate: i.e., the percentage of queries that can be answered by the cache.
* Cache efficiency is a fickle thing because query patterns differ for each application.
* But most query patterns have [Locality of Reference](http://en.wikipedia.org/wiki/Locality_of_reference): some data are more frequently accessed than others.
* In many cases, a small percentage of data are queried the vast majority of the time.
* If you are designing a database or a cache tier, you will want to know how much RAM to provision for the system.
* In order to design an economical database or cache tier, you may want to provision just enough RAM for the [Working Set](http://en.wikipedia.org/wiki/Working_set) and not for the entire corpus of data.

## How do I determine the size of my Working Set?

* There are some fancy computer-science ways.
* For example, if you can log all of your queries then you can measure the average and standard deviation duration between seeing the same query twice.
* Unfortunately, computing the average and standard deviation is non-trivial. People write PhD dissertations on this stuff.
* If you can log a comprehensive set of queries, you might as well play it through a simulated LRU instead.
* LRJew is a simulated LRU.

## How do I use LRJew?

* Pipe a set of queries or document identifiers into LRJew.
* For example, if you had a cache of users, pipe a log of all queries to all user-ids through it.
* Try running LRJew with different numbers of slots.
* Find the minimal amount of slots to get an acceptable cache hit rate.
* Measure the average document size in bytes (this technique is not described here).
* Multiply some numbers together.
* Provision RAM for your cloud-based peer-to-peer distributed scaling sprinkles appropriately.

## Installation

    gem install lrjew

## Contributors

* Nick Kallen
* Steve Jensen
