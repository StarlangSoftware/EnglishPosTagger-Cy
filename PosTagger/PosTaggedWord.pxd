from Dictionary.Word cimport Word


cdef class PosTaggedWord(Word):

    cdef str __tag

    cpdef str getTag(self)
