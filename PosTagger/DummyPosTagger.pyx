from Corpus.Sentence cimport Sentence

from PosTagger.PosTaggedCorpus cimport PosTaggedCorpus
from PosTagger.PosTaggedWord cimport PosTaggedWord
from PosTagger.PosTagger cimport PosTagger
import random


cdef class DummyPosTagger(PosTagger):

    cdef list __tagList

    cpdef train(self, PosTaggedCorpus corpus):
        corpusTagList = corpus.getTagList()
        self.__tagList = list(corpusTagList)

    cpdef Sentence posTag(self, Sentence sentence):
        """
        Test method for the Dummy pos tagger. For each word, the method chooses randomly a tag from all possible
        tag list.

        PARAMETERS
        ----------
        sentence : Sentence
            Sentence to be tagged.

        RETURNS
        -------
        Sentence
            Annotated (tagged) sentence.
        """
        cdef Sentence result
        cdef int i, index
        result = Sentence()
        for i in range(sentence.wordCount()):
            index = random.randint(0, len(self.__tagList) - 1)
            result.addWord(PosTaggedWord(sentence.getWord(i).getName(), self.__tagList[index]))
        return result
