from Dictionary.Word cimport Word


cdef class PosTaggedWord(Word):

    def __init__(self,
                 name: str,
                 tag: str):
        """
        A constructor of PosTaggedWord which takes name and tag as input and sets the corresponding attributes

        PARAMETERS
        ----------
        name : str
            Name of the word
        tag : str
            Tag of the word
        """
        super().__init__(name)
        self.__tag = tag

    cpdef str getTag(self):
        """
        Accessor method for tag attribute.

        RETURNS
        -------
        str
            Tag of the word.
        """
        return self.__tag
