
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{vspl-report}[2017/04/21 v1.0 Custom VSPL Rerport Class]

\RequirePackage{ifthen}
  \newboolean{@linedheaders} % chaper headers will have line above and beneath
\RequirePackage[T1]{fontenc}
\RequirePackage[ansinew]{inputenc}

\DeclareOption{tocaligned}{\setboolean{@tocaligned}{true}}
\DeclareOption{linedheaders}{\setboolean{@linedheaders}{true}}

\PassOptionsToClass{10pt,notitlepage}{report}
\DeclareOption*{%
      \PassOptionsToClass{\CurrentOption}{report}%
}
\ProcessOptions\relax
\LoadClass{report}

%---------------------------------------------------------
% Package list
%
%---------------------------------------------------------
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\PassOptionsToPackage{dvipsnames}{xcolor}
\RequirePackage{xcolor} % [dvipsnames]
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{tikz}
\RequirePackage{soul}
\RequirePackage{textcase} % for \MakeTextUppercase
\RequirePackage{type1cm}  % for Arbitrary scaling of Computer Modern Fonts

%---------------------------------------------------------
% Colors should go to vspl-colors.sty
%
%---------------------------------------------------------
\definecolor{halfgray}{gray}{0.55} % chapter numbers will be semi transparent .5 .55 .6 .0
\definecolor{webgreen}{rgb}{0,.5,0}
\definecolor{webbrown}{rgb}{.6,0,0}

%---------------------------------------------------------
%
%
%---------------------------------------------------------
\fancyhf{}
\fancyhead[LE,RO]{\thepage}
\fancyhead[RE]{\textit{ \nouppercase{\leftmark}} }
\fancyhead[LO]{\textit{ \nouppercase{\rightmark}} }

\fancypagestyle{plain}{ %
  \fancyhf{} % remove everything
  \renewcommand{\headrulewidth}{0pt} % remove lines as well
  \renewcommand{\footrulewidth}{0pt}
}

%---------------------------------------------------------
%
%
%---------------------------------------------------------
\sodef\allcapsspacing{\sffamily\upshape}%
%{0.15em}{0.65em}{0.6em}%
{0.1em}{0.3em}{0.3em}%
\sodef\lowsmallcapsspacing{\sffamily\scshape}%
{0.075em}{0.5em}{0.6em}%
\DeclareRobustCommand{\spacedallcaps}[1]{%
	\MakeTextUppercase{\allcapsspacing{#1}}}%
\DeclareRobustCommand{\spacedlowsmallcaps}[1]{%
	\MakeTextLowercase{\scshape%
	{\lowsmallcapsspacing{#1}}}}%

\newfont{\partNumFont}{eurb10 scaled 4000} % displays PART-1
\newfont{\chapterNumFont}{eurb10 scaled 5000} % displays PART-1
%\newfont{\sectionNumFont}{}
%\newfont{\subsectionNumFont}{}
%\newfont{\subsectionNumFont}{}

\newcommand{\partHeadingFormat}{\color{OliveGreen}\partNumFont\Huge\bfseries\spacedallcaps}
\newcommand{\chapterHeadingFont}{\Huge\bfseries\spacedallcaps}
\newcommand{\sectionHeadingFont}{\LARGE\bfseries\spacedallcaps}
\newcommand{\subsectionHeadingFont}{\Large\bfseries\spacedallcaps}
\newcommand{\subsubsectionHeadingFont}{\large\bfseries\spacedallcaps}

%---------------------------------------------------------
% Title Formatting
%
%---------------------------------------------------------
\newcommand{\chapterNumber}{%
  \fontsize{50}{50}\usefont{U}{ppl}{b}{n}}
\newcommand{\partNameFont}{%
  \fontsize{40}{40}\usefont{T1}{ppl}{b}{n}}

\titleformat{\part}[display]%
        {\normalfont\centering\large}%
        {\thispagestyle{empty}\partNameFont\partname~\MakeTextUppercase{\thepart}}{1em}%
        {\partHeadingFormat}%

\newcommand\formatchapter[1]{%
	\vbox to \ht\strutbox{
	\setbox0=\hbox{\chapterNumber\thechapter\hspace{10pt}\vline\ }
	\advance\hsize-\wd0 \advance\hsize-10pt\raggedright
		\bfseries\Huge\spacedallcaps{#1}\vss}}

\ifthenelse{\boolean{@linedheaders}} {%
    \titleformat{\chapter}[display]%
        {\relax} %
	{\raggedleft{\color{halfgray}%
        	\mbox{\color{OliveGreen}\chapterNumFont\thechapter}}}{0pt}%
        {\titlerule\vspace*{.9\baselineskip}\raggedright%
        \chapterHeadingFont}%
        [\normalsize\vspace*{.8\baselineskip}\titlerule]%
    }{%
    \titleformat{\chapter}[block]%
        {\normalfont\Large\sffamily}%
        {{\color{OliveGreen}\chapterNumFont\thechapter%
        \hspace{10pt}\vline}  }{10pt}%
        {\chapterHeadingFont}}
   % sections
    \titleformat{\section}
          {\Large}{\scshape%
          {\MakeTextLowercase{\sectionHeadingFont{\thesection}}}}%
         {1em}{\sectionHeadingFont}
    % subsections
    \titleformat{\subsection}
        {}{\scshape{\MakeTextLowercase%
        {\subsectionHeadingFont{\thesubsection}}}}{1em}{\subsectionHeadingFont}
    % subsubsections
    \titleformat{\subsubsection}
        {\itshape}{\scshape%
        {\MakeTextLowercase{\thesubsubsection}}}%
        {1em}{\subsubsectionHeadingFont}
    % paragraphs
    \titleformat{\paragraph}[runin]
        {\normalfont\normalsize\sffamily}{\scshape%
        {\MakeTextLowercase{\theparagraph}}}%
        {0pt}{\spacedlowsmallcaps}
    % descriptionlabels
    \renewcommand{\descriptionlabel}[1]{\hspace*{\labelsep}%
    \bfseries\spacedlowsmallcaps{#1}}
    \titlespacing*{\chapter}{0pt}{1\baselineskip}%
    {2\baselineskip}
    \titlespacing*{\section}{0pt}{2\baselineskip}%
    {.8\baselineskip}[\marginparsep]
    \titlespacing*{\subsection}{0pt}{1.5\baselineskip}%
    {.8\baselineskip}[\marginparsep]
    \titlespacing*{\paragraph}{0pt}{1\baselineskip}%
    {1\baselineskip}


%---------------------------------------------------------
% Title Formatting
%
%---------------------------------------------------------
\newcommand*{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand*{\subsubtitle}[1]{\def\@subsubtitle{#1}}

% \usefont{<encoding>}{<family>}{<series>}{<shape>}
%         {T1/U/OT1}
%                   {see vspl-fonts.sty}
%                               {b(bold)/m(medium)/r(regular)/l(light)/bx(verybold)}
%                                         {n(normal)/it(itallic)/sc(smallcaps)/sl(slanted)
\newcommand{\vspltitleFont}{%
  \fontsize{50}{50}\usefont{T1}{ppl}{b}{n}}

\renewcommand\maketitle{%
	\begin{titlepage}
	\begin{tikzpicture}[remember picture, overlay]
		% Green boundary
		\node (top) at (current page.north)
		[rectangle, fill=OliveGreen, inner sep=0 pt, anchor=north,
		minimum width=1\paperwidth, minimum height=0.4cm]{};
		% Gray boundary
		\node (left) at (current page.west)
		[rectangle, fill=gray, inner sep=0pt, anchor = west,
		minimum width=4cm, minimum height=1\paperheight]{};
	\end{tikzpicture}
	\thispagestyle{empty}
	\parindent0pt

	\begin{flushright}
	\vspace{4cm}
	{\vspltitleFont\@title}

	\vspace{2cm}
	\sffamily\bfseries
	{\Large \@author}
	\vfill
	\vfill
	Vishaarga Software (P) Ltd.\\
	\normalfont\sffamily
	Kodihalli,Bengaluru,Karanataka\\
	\bfseries{India}
	\end{flushright}
	\end{titlepage}
	\newpage
}

%---------------------------------------------------------
% Title Formatting
%
%---------------------------------------------------------
\PassOptionsToPackage{titles}{tocloft}
    \RequirePackage{tocloft}
    % avoid page numbers being right-aligned in fixed-size box              
    \newlength{\newnumberwidth}
    \settowidth{\newnumberwidth}{999} % yields overfull hbox warnings for pages > 999
    \cftsetpnumwidth{\newnumberwidth}

    % have the bib neatly positioned after the rest
    \newlength{\beforebibskip}  
    \setlength{\beforebibskip}{0em}

    \newlength{\newchnumberwidth}
    \settowidth{\newchnumberwidth}{.}

    \addtolength{\cftpartnumwidth}{\newchnumberwidth}%
    %\addtolength{\cftchapnumwidth}{\newchnumberwidth}%
    %\addtolength{\cftsecnumwidth}{\newchnumberwidth}
    %\addtolength{\cftsecindent}{\newchnumberwidth}
    %\addtolength{\cftsubsecnumwidth}{\newchnumberwidth}
    %\addtolength{\cftsubsecindent}{2\newchnumberwidth}
    %\addtolength{\cftsubsubsecnumwidth}{\newchnumberwidth}
   
    % Parts
    \setlength{\cftbeforepartskip}{3em}%
    \renewcommand{\thepart}{\MakeTextUppercase{\roman{part}}}%
    \renewcommand{\cftpartpresnum}{\scshape}%  \MakeTextLowercase
    % \renewcommand{\cftpartaftersnum}{\cftchapaftersnum}%
    % \renewcommand{\cftpartaftersnumb}{\quad}%
    \setlength{\cftpartnumwidth}{\cftpartnumwidth}
    \renewcommand{\cftpartfont}{\color{OliveGreen}\sffamily\bfseries\Large}%
    \renewcommand{\cftpartpagefont}{\color{OliveGreen}\sffamily\bfseries\Large}%
    \renewcommand{\cftpartleader}{\hspace{2.5em}}% 
    \renewcommand{\cftpartafterpnum}{\cftparfillskip}%

    \setlength{\beforebibskip}{\cftbeforepartskip}%

    % Chapters 
    \setlength{\cftbeforechapskip}{1em}% Above Chapter entry
    \renewcommand{\cftchappresnum}{\scshape\MakeTextLowercase}%
    \renewcommand{\cftchapfont}{\sffamily\bfseries\large}%
    \renewcommand{\cftchappagefont}{\sffamily\bfseries\large}%
    \renewcommand{\cftchapleader}{\hspace{2.5em}}% 
    \renewcommand{\cftchapafterpnum}{\cftparfillskip}% 
     
    % Sections
    \setlength{\cftbeforesecskip}{.3em}
    \renewcommand{\cftsecpresnum}{\scshape\MakeTextLowercase}%
    \renewcommand{\cftsecfont}{\sffamily\bfseries}%
    \renewcommand{\cftsecpagefont}{\sffamily\bfseries}%
    \renewcommand{\cftsecleader}{\hspace{2.5em}}% 
    \renewcommand{\cftsecafterpnum}{\cftparfillskip}%
    \renewcommand{\cftsecindent}{1.5em}

    % Subsections
    \setlength{\cftbeforesubsecskip}{.2em}
    \renewcommand{\cftsubsecpresnum}{\scshape\MakeTextLowercase}%
    \renewcommand{\cftsubsecfont}{\sffamily}%
    \renewcommand{\cftsubsecpagefont}{\sffamily}%
    \renewcommand{\cftsubsecleader}{\hspace{1.5em}}% 
    \renewcommand{\cftsubsecafterpnum}{\cftparfillskip}%   
    \renewcommand{\cftsubsecindent}{2em}

    % Subsubsections
    \renewcommand{\cftsubsubsecpresnum}{\scshape\MakeTextLowercase}%
    \renewcommand{\cftsubsubsecfont}{\sffamily}%
    \renewcommand{\cftsubsubsecpagefont}{\sffamily}%
    \renewcommand{\cftsubsubsecleader}{\hspace{1.5em}}% 
    \renewcommand{\cftsubsubsecafterpnum}{\cftparfillskip}%   
    \renewcommand{\cftsubsubsecindent}{0em}

    % Figures     
    \renewcommand{\cftfigpresnum}{\scshape\MakeTextLowercase}% 
    \renewcommand{\cftfigfont}{\sffamily}%                 
    \renewcommand{\cftfigleader}{\hspace{1.5em}}% 
    \renewcommand{\cftfigafterpnum}{\cftparfillskip}%
    \renewcommand{\cftfigpresnum}{\figurename~}%Fig.~}

    % Tables
    \newlength{\figurelabelwidth}
    \settowidth{\figurelabelwidth}{\cftfigpresnum~999}
    \addtolength{\figurelabelwidth}{2.5em}
    \cftsetindents{figure}{0em}{\figurelabelwidth}

    % dirty work-around to get the spacing after the toc/lot/lof-titles right    
    \AtBeginDocument{\addtocontents{toc}{\protect\vspace{-\cftbeforepartskip}}}
    \AtBeginDocument{\addtocontents{toc}{\protect\vspace{-\cftbeforechapskip}}}



\endinput
