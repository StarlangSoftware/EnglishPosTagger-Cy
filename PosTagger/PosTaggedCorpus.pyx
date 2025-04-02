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
        cdef Sentence new_sentence
        cdef list lines, words
        cdef str line, word, name, tag, short_tag
        self.sentences = []
        self.word_list = CounterHashMap()
        self.__tag_list = CounterHashMap()
        new_sentence = Sentence()
        if fileName is not None:
            input_file = open(fileName, "r", encoding="utf8")
            lines = input_file.readlines()
            input_file.close()
            for line in lines:
                words = re.split("[\t\n ]", line)
                for word in words:
                    if len(word) > 0 and "/" in word:
                        name = word[:word.rindex("/")]
                        tag = word[word.rindex("/") + 1:]
                        if "+" in tag:
                            short_tag = tag[:tag.index("+")]
                        elif "-" in tag:
                            short_tag = tag[:tag.index("-")]
                        else:
                            short_tag = tag
                        self.__tag_list.put(short_tag)
                        new_sentence.addWord(PosTaggedWord(name, short_tag))
                        if tag == '.':
                            self.addSentence(new_sentence)
                            new_sentence = Sentence()
            if new_sentence.wordCount() > 0:
                self.addSentence(new_sentence)

    def getTagList(self) -> KeysView:
        """
        getTagList returns all possible tags as a set.

        RETURNS
        -------
        set
            Set of all possible tags.
        """
        return self.__tag_list.keys()
