\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{python-problem}[2014/05/26 v0.0.1 Python Problem Set class]

%% If we go for US paper, adjust the height accordingly.
\DeclareOption{letterpaper}{%
  \AtEndOfClass{\addtolength{\voffset}{5em}}
  \AtEndOfClass{\addtolength{\textheight}{-10em}}
  \PassOptionsToClass{letterpaper}{article}
}

%% Should acronym definitions create new macros.
\DeclareOption{acro-macros}{%
  \PassOptionsToPackage{macros}{acro}
}

%% Send all unknown things to article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

\ProcessOptions\relax
\LoadClass{article}

%% Base appearence.
\RequirePackage[nochapters]{classicthesis}

%% Use fun fonts. This set of macros must be after classicthesis, as it
%% redefines some macros.
\ifcsname ifppcustomfonts\endcsname%
  \RequirePackage{fontspec}
  \setmonofont[Scale=MatchLowercase]{PragmataPro}
  %\setmainfont[Numbers=OldStyle]{Adobe Garamond Pro}
  \setmainfont[Numbers=OldStyle]{Sabon LT Std}
\fi

%% Nice Tables
\RequirePackage{booktabs}

%% Useful for writing macros that adapt to the structure of the text.
\RequirePackage{xspace}

%% Write code in the document. With some default appearence options.
\RequirePackage{minted}
\usemintedstyle{tango}
\newminted{py}{linenos, numbersep=5pt, frame=lines, framesep=2mm}
\newmintedfile[pyfile]{python}{linenos, numbersep=5pt, frame=lines, %
                               framesep=2mm}

%% Fun and fabulous acronyms.
\RequirePackage[xspace]{acro}
\acsetup{short-format = {\scshape}}

%% Allows for the use of resume
\RequirePackage{enumitem}

%% Set the problem set number.
\DeclareRobustCommand*{\problemset}[1]{%
  \expandafter\newcommand\csname pp@problemset\endcsname{#1}%
}

%% If the problem set number exists, then use a default title. Otherwise,
%% use a title given in the preamble.
\AtBeginDocument{%
  \ifcsname pp@problemset\endcsname%
    \title{\rmfamily\normalfont\spacedallcaps{python problem}\, %
      $\expandafter\csname pp@problemset\endcsname$}%
  \fi%
}

%% Solutions section. If the ifppsolution is set to false, then any parts
%% after this macro in the document are not compiled (compilation will end
%% at this command). However, if the ifppsolution is true, then the entire
%% file is compiled.
\ifcsname ifppsolutions\endcsname\else%
  \expandafter\let\csname ifppsolutions\expandafter\endcsname%
  \csname iffalse\endcsname
\fi

\DeclareRobustCommand*{\beginsolution}{%
  \ifppsolutions
    \setlist[enumerate,1]{leftmargin=0em}
  \else
    \end{document}
    \endinput
  \fi
}

%% Some useful common macros.
\newcommand{\BigO}[1]{\ensuremath{O(#1)}\xspace}
\newcommand{\code}[1]{\texttt{#1}\xspace}

