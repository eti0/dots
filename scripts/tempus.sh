#!/usr/bin/env fish


# vars
set currenthour (date +%H)
set currentminute (date +%M)


# hours
set h00 "minuit"
set h01 "une heure"
set h02 "deux heures"
set h03 "trois heures"
set h04 "quatre heures"
set h05 "cinq heures"
set h06 "six heures"
set h07 "sept heures"
set h08 "huit heures"
set h09 "neuf heures"
set h10 "dix heures"
set h11 "onze heures"
set h12 "douze heures"
set h13 "treize heures"
set h14 "quatorze heures"
set h15 "quinze heures"
set h16 "seize heures"
set h17 "dix-sept heures"
set h18 "dix-huit heures"
set h19 "dix-neuf heures"
set h20 "vingt heures"
set h21 "vingt-et-une heures"
set h22 "vingt-deux heures"
set h23 "vingt-trois heures"


# minutes
set m00 ""
set m01 "une"
set m02 "deux"
set m03 "trois"
set m04 "quatre"
set m05 "cinq"
set m06 "six"
set m07 "sept"
set m08 "huit"
set m09 "neuf"
set m10 "dix"
set m11 "onze"
set m12 "douze"
set m13 "treize"
set m14 "quatorze"
set m15 "quinze"
set m16 "seize"
set m17 "dix-sept"
set m18 "dix-huit"
set m19 "dix-neuf"
set m20 "vingt"
set m21 "vingt-et-une"
set m22 "vingt-deux"
set m23 "vingt-trois"
set m24 "vingt-quatre"
set m25 "vingt-cinq"
set m26 "vingt-six"
set m27 "vingt-sept"
set m28 "vingt-huit"
set m29 "vingt-neuf"
set m30 "trente"
set m31 "trente-et-une"
set m32 "trente-deux"
set m33 "trente-trois"
set m34 "trente-quatre"
set m35 "trente-cinq"
set m36 "trente-six"
set m37 "trente-sept"
set m38 "trente-huit"
set m39 "trente-neuf"
set m40 "quarante"
set m41 "quarante-et-une"
set m42 "quarante-deux"
set m43 "quarante-trois"
set m44 "quarante-quatre"
set m45 "quarante-cinq"
set m46 "quarante-six"
set m47 "quarante-sept"
set m48 "quarante-huit"
set m49 "quarante-neuf"
set m50 "cinquante"
set m51 "cinquante-et-une"
set m52 "cinquante-deux"
set m53 "cinquante-trois"
set m54 "cinquante-quatre"
set m55 "cinquante-cinq"
set m56 "cinquante-six"
set m57 "cinquante-sept"
set m58 "cinquante-huit"
set m59 "cinquante-neuf"


# funcs
function space
	printf " "
end

function hour
	switch $currenthour
		case 00
			printf $h00
		case 01
			printf $h01
		case 02
			printf $h02
		case 03
			printf $h03
		case 04
			printf $h04
		case 05
			printf $h05
		case 06
			printf $h06
		case 07
			printf $h07
		case 08
			printf $h08
		case 09
			printf $h09
		case 10
			printf $h10
		case 11
			printf $h11
		case 12
			printf $h12
		case 13
			printf $h13
		case 14
			printf $h14
		case 15
			printf $h15
		case 16
			printf $h16
		case 17
			printf $h17
		case 18
			printf $h18
		case 19
			printf $h19
		case 20
			printf $h20
		case 21
			printf $h21
		case 22
			printf $h22
		case 23
			printf $h23
	end
end

function minute
	switch $currentminute
		case 00
			printf $m00
		case 01
			printf $m01
		case 02
			printf $m02
		case 03
			printf $m03
		case 04
			printf $m04
		case 05
			printf $m05
		case 06
			printf $m06
		case 07
			printf $m07
		case 08
			printf $m08
		case 09
			printf $m09
		case 10
			printf $m10
		case 11
			printf $m11
		case 12
			printf $m12
		case 13
			printf $m13
		case 14
			printf $m14
		case 15
			printf $m15
		case 16
			printf $m16
		case 17
			printf $m17
		case 18
			printf $m18
		case 19
			printf $m19
		case 20
			printf $m20
		case 21
			printf $m21
		case 22
			printf $m22
		case 23
			printf $m23
		case 24
			printf $m24
		case 25
			printf $m25
		case 26
			printf $m26
		case 27
			printf $m27
		case 28
			printf $m28
		case 29
			printf $m29
		case 30
			printf $m30
		case 31
			printf $m31
		case 32
			printf $m32
		case 33
			printf $m33
		case 34
			printf $m34
		case 35
			printf $m35
		case 36
			printf $m36
		case 37
			printf $m37
		case 38
			printf $m38
		case 39
			printf $m39
		case 40
			printf $m40
		case 41
			printf $m41
		case 42
			printf $m42
		case 43
			printf $m43
		case 44
			printf $m44
		case 45
			printf $m45
		case 46
			printf $m46
		case 47
			printf $m47
		case 48
			printf $m48
		case 49
			printf $m49
		case 50
			printf $m50
		case 51
			printf $m51
		case 52
			printf $m52
		case 53
			printf $m53
		case 54
			printf $m54
		case 55
			printf $m55
		case 56
			printf $m56
		case 57
			printf $m57
		case 58
			printf $m58
		case 59
			printf $m59
	end
end

# exec
hour
space
minute
