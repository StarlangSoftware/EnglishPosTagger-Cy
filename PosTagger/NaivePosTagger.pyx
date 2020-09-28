from Corpus.Sentence cimport Sentence
from DataStructure.CounterHashMap cimport CounterHashMap

from PosTagger.PosTaggedCorpus cimport PosTaggedCorpus
from PosTagger.PosTaggedWord cimport PosTaggedWord
from PosTagger.PosTagger cimport PosTagger


cdef class NaivePosTagger(PosTagger):

    cdef dict __maxMap

    cpdef train(self, PosTaggedCorpus corpus):
        """
        Train method for the Naive pos tagger. The algorithm gets all possible tag list. Then counts all
        possible tags (with its counts) for each possible word.

        PARAMETERS
        ----------
        corpus : PosTaggedCorpus
            Training data for the tagger.
        """
        cdef dict wordMap
        cdef int i, j
        cdef Sentence s
        cdef PosTaggedWord taggedWord
        cdef str word
        cdef CounterHashMap counterMap
        wordMap = {}
        for i in range(corpus.sentenceCount()):
            s = corpus.getSentence(i)
            for j in range(s.wordCount()):
                taggedWord = corpus.getSentence(i).getWord(j)
                if isinstance(taggedWord, PosTaggedWord):
                    if taggedWord.getName() in wordMap:
                        wordMap[taggedWord.getName()].put(taggedWord.getTag())
                    else:
                        counterMap = CounterHashMap()
                        counterMap.put(taggedWord.getTag())
                        wordMap[taggedWord.getName()] = counterMap
        self.__maxMap = {}
        for word in wordMap:
            self.__maxMap[word] = wordMap[word].max()

    cpdef Sentence posTag(self, Sentence sentence):
        """
        Test method for the Naive pos tagger. For each word, the method chooses the maximum a posterior tag from all
        possible tag list for that word.

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
        cdef int i
        result = Sentence()
        for i in range(sentence.wordCount()):
            result.addWord(PosTaggedWord(sentence.getWord(i).getName(), self.__maxMap[sentence.getWord(i).getName()]))
        return result
