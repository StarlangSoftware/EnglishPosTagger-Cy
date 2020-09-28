from Corpus.Sentence cimport Sentence
from Hmm.Hmm cimport Hmm
from Hmm.Hmm1 cimport Hmm1

from PosTagger.PosTaggedCorpus cimport PosTaggedCorpus
from PosTagger.PosTaggedWord cimport PosTaggedWord
from PosTagger.PosTagger cimport PosTagger


cdef class HmmPosTagger(PosTagger):

    cdef Hmm __hmm

    cpdef train(self, PosTaggedCorpus corpus):
        """
        Train method for the Hmm pos tagger. The algorithm trains an Hmm from the corpus, where corpus constitutes
        as an observation array.

        PARAMETERS
        ----------
        corpus : Corpus
            Training data for the tagger.
        """
        cdef list emittedSymbols
        cdef int i, j
        cdef PosTaggedWord word
        emittedSymbols = []
        for i in range(corpus.sentenceCount()):
            emittedSymbols.append([])
            for j in range(corpus.getSentence(i).wordCount()):
                word = corpus.getSentence(i).getWord(j)
                if isinstance(word, PosTaggedWord):
                    emittedSymbols[i].append(word.getTag())
        self.__hmm = Hmm1(set(corpus.getTagList()), emittedSymbols, corpus.getAllWordsAsList())

    cpdef Sentence posTag(self, Sentence sentence):
        """
        Test method for the Hmm pos tagger. For each sentence, the method uses the viterbi algorithm to produce the
        most possible state sequence for the given sentence.

        PARAMETERS
        ----------
        sentence : Sentence
            Sentence to be tagged.

        RETURN
        ------
        Sentence
            Annotated (tagged) sentence.
        """
        cdef Sentence result
        cdef int i
        cdef list tagList
        result = Sentence()
        tagList = self.__hmm.viterbi(sentence.getWords())
        for i in range(sentence.wordCount()):
            result.addWord(PosTaggedWord(sentence.getWord(i).getName(), tagList[i]))
        return result
