# The quran package
Copyright © 2015-2026

The package is designed for typesetting the Holy Quran.
It offers several macros for typesetting the entire text
or specific sections, based on its traditional divisions.


## Sample Usage

```
\documentclass{article}

\usepackage{arabxetex}
\usepackage{quran}

\begin{document}

    \begin{arab}[utf]
        \quransurah
        \medskip
        \quransurah*[108]
    \end{arab}

\end{document}
```
![surah108](images/sample.png)

## Documentation
For further details, please refer to [this link](http://mirrors.ctan.org/macros/unicodetex/latex/quran/doc/quran-doc.pdf).


## License

[The LaTeX project public license (LPPL), version 1.3c](https://www.latex-project.org/lppl/lppl-1-3c/)

## Citation

```tex
@misc{quran,
  title={{quran}: An easy way to typeset any part of The Holy Quran},
  url={https://ctan.org/pkg/quran},
  note={Available at https://github.com/javadr/quran},
  author={Javad Razavian},
  year={2015},
}
```