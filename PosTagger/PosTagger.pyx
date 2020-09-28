cdef class PosTagger:

    cpdef train(self, PosTaggedCorpus corpus):
        pass

    cpdef Sentence posTag(self, Sentence sentence):
        pass
