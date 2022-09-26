from DataStructure.CounterHashMap cimport CounterHashMap
from Corpus.Corpus cimport Corpus


cdef class PosTaggedCorpus(Corpus):

    cdef CounterHashMap __tag_list
