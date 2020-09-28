from Corpus.Sentence cimport Sentence
from PosTagger.PosTaggedCorpus cimport PosTaggedCorpus


cdef class PosTagger:

    cpdef train(self, PosTaggedCorpus corpus)
    cpdef Sentence posTag(self, Sentence sentence)
