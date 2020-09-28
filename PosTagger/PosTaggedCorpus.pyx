from collections import KeysView

from Corpus.Sentence cimport Sentence

from PosTagger.PosTaggedWord cimport PosTaggedWord
import re


cdef class PosTaggedCorpus(Corpus):

    def __init__(self, fileName:str = None):
        """
        A constructor of PosTaggedCorpus which initializes the sentences of the corpus, the word list of
        the corpus, and all possible tags.

        PARAMETERS
        ----------
        fileName : str
            Name of the corpus file.
        """
        cdef Sentence newSentence
        cdef list lines, words
        cdef str line, word, name, tag, shortTag
        self.sentences = []
        self.wordList = CounterHashMap()
        self.__tagList = CounterHashMap()
        newSentence = Sentence()
        if fileName is not None:
            inputFile = open(fileName, "r", encoding="utf8")
            lines = inputFile.readlines()
            for line in lines:
                words = re.split("[\t\n ]", line)
                for word in words:
                    if len(word) > 0 and "/" in word:
                        name = word[:word.rindex("/")]
                        tag = word[word.rindex("/") + 1:]
                        if "+" in tag:
                            shortTag = tag[:tag.index("+")]
                        elif "-" in tag:
                            shortTag = tag[:tag.index("-")]
                        else:
                            shortTag = tag
                        self.__tagList.put(shortTag)
                        newSentence.addWord(PosTaggedWord(name, shortTag))
                        if tag == '.':
                            self.addSentence(newSentence)
                            newSentence = Sentence()
            if newSentence.wordCount() > 0:
                self.addSentence(newSentence)

    def getTagList(self) -> KeysView:
        """
        getTagList returns all possible tags as a set.

        RETURNS
        -------
        set
            Set of all possible tags.
        """
        return self.__tagList.keys()
