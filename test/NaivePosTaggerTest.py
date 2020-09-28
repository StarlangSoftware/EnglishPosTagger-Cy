import unittest

from PosTagger.NaivePosTagger import NaivePosTagger
from PosTagger.PosTaggedCorpus import PosTaggedCorpus


class NaivePosTaggerTest(unittest.TestCase):

    def test_PosTag(self):
        posTagger = NaivePosTagger()
        posTaggedCorpus = PosTaggedCorpus("../brown.txt")
        posTagger.train(posTaggedCorpus)
        correct = 0
        incorrect = 0
        for i in range(posTaggedCorpus.sentenceCount()):
            taggedSentence = posTagger.posTag(posTaggedCorpus.getSentence(i))
            for j in range(taggedSentence.wordCount()):
                if (posTaggedCorpus.getSentence(i).getWord(j)).getTag() == taggedSentence.getWord(j).getTag():
                    correct = correct + 1
                else:
                    incorrect = incorrect + 1
        self.assertAlmostEqual(93.69, 100 * correct / (correct + incorrect), 2)


if __name__ == '__main__':
    unittest.main()
