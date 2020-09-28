import unittest

from PosTagger.DummyPosTagger import DummyPosTagger
from PosTagger.PosTaggedCorpus import PosTaggedCorpus


class DummyPosTaggerTest(unittest.TestCase):

    def test_PosTag(self):
        posTagger = DummyPosTagger()
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
        self.assertAlmostEqual(0.88, 100 * correct / (correct + incorrect), 2)


if __name__ == '__main__':
    unittest.main()
