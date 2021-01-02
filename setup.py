from distutils.core import setup
from Cython.Build import cythonize

setup(
    ext_modules=cythonize(["PosTagger/*.pyx"],
                          compiler_directives={'language_level': "3"}),
    name='NlpToolkit-PosTagger-Cy',
    version='1.0.0',
    packages=['PosTagger'],
    package_data={'PosTagger': ['*.pxd', '*.pyx', '*.c']},
    url='https://github.com/olcaytaner/PosTagger-Cy',
    license='',
    author='olcaytaner',
    author_email='olcay.yildiz@ozyegin.edu.tr',
    description='English PosTagger Library',
    install_requires=['NlpToolkit-Corpus-Cy', 'NlpToolkit-Hmm-Cy']
)
