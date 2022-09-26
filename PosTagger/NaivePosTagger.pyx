from Corpus.Sentence cimport Sentence
from DataStructure.CounterHashMap cimport CounterHashMap

from PosTagger.PosTaggedCorpus cimport PosTaggedCorpus
from PosTagger.PosTaggedWord cimport PosTaggedWord
from PosTagger.PosTagger cimport PosTagger


cdef class NaivePosTagger(PosTagger):

    cdef dict __max_map

    cpdef train(self, PosTaggedCorpus corpus):
        """
        Train method for the Naive pos tagger. The algorithm gets all possible tag list. Then counts all
        possible tags (with its counts) for each possible word.

        PARAMETERS
        ----------
        corpus : PosTaggedCorpus
            Training data for the tagger.
        """
        cdef dict word_map
        cdef int i, j
        cdef Sentence s
        cdef PosTaggedWord tagged_word
        cdef str word
        cdef CounterHashMap counter_map
        word_map = {}
        for i in range(corpus.sentenceCount()):
            s = corpus.getSentence(i)
            for j in range(s.wordCount()):
                tagged_word = corpus.getSentence(i).getWord(j)
                if isinstance(tagged_word, PosTaggedWord):
                    if tagged_word.getName() in word_map:
                        word_map[tagged_word.getName()].put(tagged_word.getTag())
                    else:
                        counter_map = CounterHashMap()
                        counter_map.put(tagged_word.getTag())
                        word_map[tagged_word.getName()] = counter_map
        self.__max_map = {}
        for word in word_map:
            self.__max_map[word] = word_map[word].max()

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
            result.addWord(PosTaggedWord(sentence.getWord(i).getName(), self.__max_map[sentence.getWord(i).getName()]))
        return result
