import unittest

from PosTagger.HmmPosTagger import HmmPosTagger
from PosTagger.PosTaggedCorpus import PosTaggedCorpus


class HmmPosTaggerTest(unittest.TestCase):

    def test_PosTag(self):
        posTagger = HmmPosTagger()
        posTaggedCorpus = PosTaggedCorpus("../brown.txt")
        posTagger.train(posTaggedCorpus)
        correct = 0
        incorrect = 0
        for i in range(posTaggedCorpus.sentenceCount()):
            if i > 0 and i % 100 == 0:
                print(i.__str__() + " " + (100 * correct / (correct + incorrect)).__str__())
            taggedSentence = posTagger.posTag(posTaggedCorpus.getSentence(i))
            for j in range(taggedSentence.wordCount()):
                if (posTaggedCorpus.getSentence(i).getWord(j)).getTag() == taggedSentence.getWord(j).getTag():
                    correct = correct + 1
                else:
                    incorrect = incorrect + 1
        self.assertAlmostEqual(97.59, 100 * correct / (correct + incorrect), 2)


if __name__ == '__main__':
    unittest.main()
