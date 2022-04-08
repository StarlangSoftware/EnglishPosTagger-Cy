Pos Tagging [<img src="https://github.com/StarlangSoftware/EnglishPosTagger/blob/master/video1.jpg" width="5%">](https://youtu.be/gQmc7Nhwhuk)
============

This is a tool meant for tagging words with their part-of-speech, a grammatical category based on their function within a sentence, such as noun, adjective, verb, and so forth. 

For Developers
============
You can also see [Python](https://github.com/starlangsoftware/EnglishPosTagger-Py), [Java](https://github.com/starlangsoftware/EnglishPosTagger), [C++](https://github.com/starlangsoftware/EnglishPosTagger-CPP), [Swift](https://github.com/starlangsoftware/EnglishPosTagger-Swift), [Js](https://github.com/starlangsoftware/EnglishPosTagger-Js), or [C#](https://github.com/starlangsoftware/EnglishPosTagger-CS) repository.

## Requirements

* [Python 3.7 or higher](#python)
* [Git](#git)

### Python 

To check if you have a compatible version of Python installed, use the following command:

    python -V
    
You can find the latest version of Python [here](https://www.python.org/downloads/).

### Git

Install the [latest version of Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

## Pip Install

	pip3 install NlpToolkit-PosTagger-Cy

## Download Code

In order to work on code, create a fork from GitHub page. 
Use Git for cloning the code to your local or below line for Ubuntu:

	git clone <your-fork-git-link>

A directory called EnglishPosTagger will be created. Or you can use below link for exploring the code:

	git clone https://github.com/starlangsoftware/EnglishPosTagger-Cy.git

## Open project with Pycharm IDE

Steps for opening the cloned project:

* Start IDE
* Select **File | Open** from main menu
* Choose `EnglishPosTagger-Cy` file
* Select open as project option
* Couple of seconds, dependencies will be downloaded. 

Detailed Description
============

+ [PosTagger](#postagger)

## PosTagger

To train the PosTagger which is used for English pos tagging 

	train(self, corpus: PosTaggedCorpus)
	
To save the trained PosTagger model

	saveModel(self)
	
To load an already trained PosTagger model

	loadModel(self)
	
To tag a sentence, using a newly trained or loaded PosTagger model

	posTag(self, sentence: Sentence) -> Sentence
	
3 different PosTagger models are supported: The one that is used to tag the sentences with a random tag

	DummyPosTagger
	
the one that tags the word with the most used tag for a given word

	NaivePosTagger
	
the one that does an Hmm based training and tags the words accordingly

	HmmPosTagger
