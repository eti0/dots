#!/usr/bin/env fish


# vars
set currenthour (math (date +%H) + 1)
set currentminute (math (date +%M) + 1)


# hours
set h[01] "minuit"
set h[02] "une heure"
set h[03] "deux heures"
set h[04] "trois heures"
set h[05] "quatre heures"
set h[06] "cinq heures"
set h[07] "six heures"
set h[08] "sept heures"
set h[09] "huit heures"
set h[10] "neuf heures"
set h[11] "dix heures"
set h[12] "onze heures"
set h[13] "midi"
set h[14] "treize heures"
set h[15] "quatorze heures"
set h[16] "quinze heures"
set h[17] "seize heures"
set h[18] "dix-sept heures"
set h[19] "dix-huit heures"
set h[20] "dix-neuf heures"
set h[21] "vingt heures"
set h[22] "vingt-et-une heures"
set h[23] "vingt-deux heures"
set h[24] "vingt-trois heures"


# minutes
set m[01] ""
set m[02] "une"
set m[03] "deux"
set m[04] "trois"
set m[05] "quatre"
set m[06] "cinq"
set m[07] "six"
set m[08] "sept"
set m[09] "huit"
set m[10] "neuf"
set m[11] "dix"
set m[12] "onze"
set m[13] "douze"
set m[14] "treize"
set m[15] "quatorze"
set m[16] "quinze"
set m[17] "seize"
set m[18] "dix-sept"
set m[19] "dix-huit"
set m[20] "dix-neuf"
set m[21] "vingt"
set m[22] "vingt-et-une"
set m[23] "vingt-deux"
set m[24] "vingt-trois"
set m[25] "vingt-quatre"
set m[26] "vingt-cinq"
set m[27] "vingt-six"
set m[28] "vingt-sept"
set m[29] "vingt-huit"
set m[30] "vingt-neuf"
set m[31] "trente"
set m[32] "trente-et-une"
set m[33] "trente-deux"
set m[34] "trente-trois"
set m[35] "trente-quatre"
set m[36] "trente-cinq"
set m[37] "trente-six"
set m[38] "trente-sept"
set m[39] "trente-huit"
set m[40] "trente-neuf"
set m[41] "quarante"
set m[42] "quarante-et-une"
set m[43] "quarante-deux"
set m[44] "quarante-trois"
set m[45] "quarante-quatre"
set m[46] "quarante-cinq"
set m[47] "quarante-six"
set m[48] "quarante-sept"
set m[49] "quarante-huit"
set m[50] "quarante-neuf"
set m[51] "cinquante"
set m[52] "cinquante-et-une"
set m[53] "cinquante-deux"
set m[54] "cinquante-trois"
set m[55] "cinquante-quatre"
set m[56] "cinquante-cinq"
set m[57] "cinquante-six"
set m[58] "cinquante-sept"
set m[59] "cinquante-huit"
set m[60] "cinquante-neuf"


# funcs
function hour
    printf $h[$currenthour]
end

function minute
    printf $m[$currentminute]
end

# exec
hour
printf " : "
minute
