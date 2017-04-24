/*!
 * jQuery Validation Plugin v1.15.0
 *
 * http://jqueryvalidation.org/
 *
 * Copyright (c) 2016 Jörn Zaefferer
 * Released under the MIT license
 */
(function( factory ) {
	if ( typeof define === "function" && define.amd ) {
		define( ["jquery", "./jquery.validate"], factory );
	} else if (typeof module === "object" && module.exports) {
		module.exports = factory( require( "jquery" ) );
	} else {
		factory( jQuery );
	}
}(function( $ ) {

( function() {

	function stripHtml( value ) {

		// Remove html tags and space chars
		return value.replace( /<.[^<>]*?>/g, " " ).replace( /&nbsp;|&#160;/gi, " " )

		// Remove punctuation
		.replace( /[.(),;:!?%#$'\"_+=\/\-“”’]*/g, "" );
	}

	$.validator.addMethod( "maxWords", function( value, element, params ) {
		return this.optional( element ) || stripHtml( value ).match( /\b\w+\b/g ).length <= params;
	}, $.validator.format( "Please enter {0} words or less." ) );

	$.validator.addMethod( "minWords", function( value, element, params ) {
		return this.optional( element ) || stripHtml( value ).match( /\b\w+\b/g ).length >= params;
	}, $.validator.format( "Please enter at least {0} words." ) );

	$.validator.addMethod( "rangeWords", function( value, element, params ) {
		var valueStripped = stripHtml( value ),
			regex = /\b\w+\b/g;
		return this.optional( element ) || valueStripped.match( regex ).length >= params[ 0 ] && valueStripped.match( regex ).length <= params[ 1 ];
	}, $.validator.format( "Please enter between {0} and {1} words." ) );

}() );

// Accept a value from a file input based on a required mimetype
$.validator.addMethod( "accept", function( value, element, param ) {

	// Split mime on commas in case we have multiple types we can accept
	var typeParam = typeof param === "string" ? param.replace( /\s/g, "" ) : "image/*",
	optionalValue = this.optional( element ),
	i, file, regex;

	// Element is optional
	if ( optionalValue ) {
		return optionalValue;
	}

	if ( $( element ).attr( "type" ) === "file" ) {

		// Escape string to be used in the regex
		// see: http://stackoverflow.com/questions/3446170/escape-string-for-use-in-javascript-regex
		// Escape also "/*" as "/.*" as a wildcard
		typeParam = typeParam.replace( /[\-\[\]\/\{\}\(\)\+\?\.\\\^\$\|]/g, "\\$&" ).replace( /,/g, "|" ).replace( "\/*", "/.*" );

		// Check if the element has a FileList before checking each file
		if ( element.files && element.files.length ) {
			regex = new RegExp( ".?(" + typeParam + ")$", "i" );
			for ( i = 0; i < element.files.length; i++ ) {
				file = element.files[ i ];

				// Grab the mimetype from the loaded file, verify it matches
				if ( !file.type.match( regex ) ) {
					return false;
				}
			}
		}
	}

	// Either return true because we've validated each file, or because the
	// browser does not support element.files and the FileList feature
	return true;
}, $.validator.format( "Please enter a value with a valid mimetype." ) );

$.validator.addMethod( "alphanumeric", function( value, element ) {
	return this.optional( element ) || /^\w+$/i.test( value );
}, "Letters, numbers, and underscores only please" );

/*
 * Dutch bank account numbers (not 'giro' numbers) have 9 digits
 * and pass the '11 check'.
 * We accept the notation with spaces, as that is common.
 * acceptable: 123456789 or 12 34 56 789
 */
$.validator.addMethod( "bankaccountNL", function( value, element ) {
	if ( this.optional( element ) ) {
		return true;
	}
	if ( !( /^[0-9]{9}|([0-9]{2} ){3}[0-9]{3}$/.test( value ) ) ) {
		return false;
	}

	// Now '11 check'
	var account = value.replace( / /g, "" ), // Remove spaces
		sum = 0,
		len = account.length,
		pos, factor, digit;
	for ( pos = 0; pos < len; pos++ ) {
		factor = len - pos;
		digit = account.substring( pos, pos + 1 );
		sum = sum + factor * digit;
	}
	return sum % 11 === 0;
}, "Please specify a valid bank account number" );

$.validator.addMethod( "bankorgiroaccountNL", function( value, element ) {
	return this.optional( element ) ||
			( $.validator.methods.bankaccountNL.call( this, value, element ) ) ||
			( $.validator.methods.giroaccountNL.call( this, value, element ) );
}, "Please specify a valid bank or giro account number" );

/**
 * BIC is the business identifier code (ISO 9362). This BIC check is not a guarantee for authenticity.
 *
 * BIC pattern: BBBBCCLLbbb (8 or 11 characters long; bbb is optional)
 *
 * Validation is case-insensitive. Please make sure to normalize input yourself.
 *
 * BIC definition in detail:
 * - First 4 characters - bank code (only letters)
 * - Next 2 characters - ISO 3166-1 alpha-2 country code (only letters)
 * - Next 2 characters - location code (letters and digits)
 *   a. shall not start with '0' or '1'
 *   b. second character must be a letter ('O' is not allowed) or digit ('0' for test (therefore not allowed), '1' denoting passive participant, '2' typically reverse-billing)
 * - Last 3 characters - branch code, optional (shall not start with 'X' except in case of 'XXX' for primary office) (letters and digits)
 */
$.validator.addMethod( "bic", function( value, element ) {
    return this.optional( element ) || /^([A-Z]{6}[A-Z2-9][A-NP-Z1-9])(X{3}|[A-WY-Z0-9][A-Z0-9]{2})?$/.test( value.toUpperCase() );
}, "Please specify a valid BIC code" );

/*
 * Código de identificación fiscal ( CIF ) is the tax identification code for Spanish legal entities
 * Further rules can be found in Spanish on http://es.wikipedia.org/wiki/C%C3%B3digo_de_identificaci%C3%B3n_fiscal
 */
$.validator.addMethod( "cifES", function( value ) {
	"use strict";

	var num = [],
		controlDigit, sum, i, count, tmp, secondDigit;

	value = value.toUpperCase();

	// Quick format test
	if ( !value.match( "((^[A-Z]{1}[0-9]{7}[A-Z0-9]{1}$|^[T]{1}[A-Z0-9]{8}$)|^[0-9]{8}[A-Z]{1}$)" ) ) {
		return false;
	}

	for ( i = 0; i < 9; i++ ) {
		num[ i ] = parseInt( value.charAt( i ), 10 );
	}

	// Algorithm for checking CIF codes
	sum = num[ 2 ] + num[ 4 ] + num[ 6 ];
	for ( count = 1; count < 8; count += 2 ) {
		tmp = ( 2 * num[ count ] ).toString();
		secondDigit = tmp.charAt( 1 );

		sum += parseInt( tmp.charAt( 0 ), 10 ) + ( secondDigit === "" ? 0 : parseInt( secondDigit, 10 ) );
	}

	/* The first (position 1) is a letter following the following criteria:
	 *	A. Corporations
	 *	B. LLCs
	 *	C. General partnerships
	 *	D. Companies limited partnerships
	 *	E. Communities of goods
	 *	F. Cooperative Societies
	 *	G. Associations
	 *	H. Communities of homeowners in horizontal property regime
	 *	J. Civil Societies
	 *	K. Old format
	 *	L. Old format
	 *	M. Old format
	 *	N. Nonresident entities
	 *	P. Local authorities
	 *	Q. Autonomous bodies, state or not, and the like, and congregations and religious institutions
	 *	R. Congregations and religious institutions (since 2008 ORDER EHA/451/2008)
	 *	S. Organs of State Administration and regions
	 *	V. Agrarian Transformation
	 *	W. Permanent establishments of non-resident in Spain
	 */
	if ( /^[ABCDEFGHJNPQRSUVW]{1}/.test( value ) ) {
		sum += "";
		controlDigit = 10 - parseInt( sum.charAt( sum.length - 1 ), 10 );
		value += controlDigit;
		return ( num[ 8 ].toString() === String.fromCharCode( 64 + controlDigit ) || num[ 8 ].toString() === value.charAt( value.length - 1 ) );
	}

	return false;

}, "Please specify a valid CIF number." );

/*
 * Brazillian CPF number (Cadastrado de Pessoas Físicas) is the equivalent of a Brazilian tax registration number.
 * CPF numbers have 11 digits in total: 9 numbers followed by 2 check numbers that are being used for validation.
 */
$.validator.addMethod( "cpfBR", function( value ) {

	// Removing special characters from value
	value = value.replace( /([~!@#$%^&*()_+=`{}\[\]\-|\\:;'<>,.\/? ])+/g, "" );

	// Checking value to have 11 digits only
	if ( value.length !== 11 ) {
		return false;
	}

	var sum = 0,
		firstCN, secondCN, checkResult, i;

	firstCN = parseInt( value.substring( 9, 10 ), 10 );
	secondCN = parseInt( value.substring( 10, 11 ), 10 );

	checkResult = function( sum, cn ) {
		var result = ( sum * 10 ) % 11;
		if ( ( result === 10 ) || ( result === 11 ) ) {
			result = 0;
		}
		return ( result === cn );
	};

	// Checking for dump data
	if ( value === "" ||
		value === "00000000000" ||
		value === "11111111111" ||
		value === "22222222222" ||
		value === "33333333333" ||
		value === "44444444444" ||
		value === "55555555555" ||
		value === "66666666666" ||
		value === "77777777777" ||
		value === "88888888888" ||
		value === "99999999999"
	) {
		return false;
	}

	// Step 1 - using first Check Number:
	for ( i = 1; i <= 9; i++ ) {
		sum = sum + parseInt( value.substring( i - 1, i ), 10 ) * ( 11 - i );
	}

	// If first Check Number (CN) is valid, move to Step 2 - using second Check Number:
	if ( checkResult( sum, firstCN ) ) {
		sum = 0;
		for ( i = 1; i <= 10; i++ ) {
			sum = sum + parseInt( value.substring( i - 1, i ), 10 ) * ( 12 - i );
		}
		return checkResult( sum, secondCN );
	}
	return false;

}, "Please specify a valid CPF number" );

// http://jqueryvalidation.org/creditcard-method/
// based on http://en.wikipedia.org/wiki/Luhn_algorithm
$.validator.addMethod( "creditcard", function( value, element ) {
	if ( this.optional( element ) ) {
		return "dependency-mismatch";
	}

	// Accept only spaces, digits and dashes
	if ( /[^0-9 \-]+/.test( value ) ) {
		return false;
	}

	var nCheck = 0,
		nDigit = 0,
		bEven = false,
		n, cDigit;

	value = value.replace( /\D/g, "" );

	// Basing min and max length on
	// http://developer.ean.com/general_info/Valid_Credit_Card_Types
	if ( value.length < 13 || value.length > 19 ) {
		return false;
	}

	for ( n = value.length - 1; n >= 0; n-- ) {
		cDigit = value.charAt( n );
		nDigit = parseInt( cDigit, 10 );
		if ( bEven ) {
			if ( ( nDigit *= 2 ) > 9 ) {
				nDigit -= 9;
			}
		}

		nCheck += nDigit;
		bEven = !bEven;
	}

	return ( nCheck % 10 ) === 0;
}, "Please enter a valid credit card number." );

/* NOTICE: Modified version of Castle.Components.Validator.CreditCardValidator
 * Redistributed under the the Apache License 2.0 at http://www.apache.org/licenses/LICENSE-2.0
 * Valid Types: mastercard, visa, amex, dinersclub, enroute, discover, jcb, unknown, all (overrides all other settings)
 */
$.validator.addMethod( "creditcardtypes", function( value, element, param ) {
	if ( /[^0-9\-]+/.test( value ) ) {
		return false;
	}

	value = value.replace( /\D/g, "" );

	var validTypes = 0x0000;

	if ( param.mastercard ) {
		validTypes |= 0x0001;
	}
	if ( param.visa ) {
		validTypes |= 0x0002;
	}
	if ( param.amex ) {
		validTypes |= 0x0004;
	}
	if ( param.dinersclub ) {
		validTypes |= 0x0008;
	}
	if ( param.enroute ) {
		validTypes |= 0x0010;
	}
	if ( param.discover ) {
		validTypes |= 0x0020;
	}
	if ( param.jcb ) {
		validTypes |= 0x0040;
	}
	if ( param.unknown ) {
		validTypes |= 0x0080;
	}
	if ( param.all ) {
		validTypes = 0x0001 | 0x0002 | 0x0004 | 0x0008 | 0x0010 | 0x0020 | 0x0040 | 0x0080;
	}
	if ( validTypes & 0x0001 && /^(5[12345])/.test( value ) ) { // Mastercard
		return value.length === 16;
	}
	if ( validTypes & 0x0002 && /^(4)/.test( value ) ) { // Visa
		return value.length === 16;
	}
	if ( validTypes & 0x0004 && /^(3[47])/.test( value ) ) { // Amex
		return value.length === 15;
	}
	if ( validTypes & 0x0008 && /^(3(0[012345]|[68]))/.test( value ) ) { // Dinersclub
		return value.length === 14;
	}
	if ( validTypes & 0x0010 && /^(2(014|149))/.test( value ) ) { // Enroute
		return value.length === 15;
	}
	if ( validTypes & 0x0020 && /^(6011)/.test( value ) ) { // Discover
		return value.length === 16;
	}
	if ( validTypes & 0x0040 && /^(3)/.test( value ) ) { // Jcb
		return value.length === 16;
	}
	if ( validTypes & 0x0040 && /^(2131|1800)/.test( value ) ) { // Jcb
		return value.length === 15;
	}
	if ( validTypes & 0x0080 ) { // Unknown
		return true;
	}
	return false;
}, "Please enter a valid credit card number." );

/**
 * Validates currencies with any given symbols by @jameslouiz
 * Symbols can be optional or required. Symbols required by default
 *
 * Usage examples:
 *  currency: ["£", false] - Use false for soft currency validation
 *  currency: ["$", false]
 *  currency: ["RM", false] - also works with text based symbols such as "RM" - Malaysia Ringgit etc
 *
 *  <input class="currencyInput" name="currencyInput">
 *
 * Soft symbol checking
 *  currencyInput: {
 *     currency: ["$", false]
 *  }
 *
 * Strict symbol checking (default)
 *  currencyInput: {
 *     currency: "$"
 *     //OR
 *     currency: ["$", true]
 *  }
 *
 * Multiple Symbols
 *  currencyInput: {
 *     currency: "$,£,¢"
 *  }
 */
$.validator.addMethod( "currency", function( value, element, param ) {
    var isParamString = typeof param === "string",
        symbol = isParamString ? param : param[ 0 ],
        soft = isParamString ? true : param[ 1 ],
        regex;

    symbol = symbol.replace( /,/g, "" );
    symbol = soft ? symbol + "]" : symbol + "]?";
    regex = "^[" + symbol + "([1-9]{1}[0-9]{0,2}(\\,[0-9]{3})*(\\.[0-9]{0,2})?|[1-9]{1}[0-9]{0,}(\\.[0-9]{0,2})?|0(\\.[0-9]{0,2})?|(\\.[0-9]{1,2})?)$";
    regex = new RegExp( regex );
    return this.optional( element ) || regex.test( value );

}, "Please specify a valid currency" );

$.validator.addMethod( "dateFA", function( value, element ) {
	return this.optional( element ) || /^[1-4]\d{3}\/((0?[1-6]\/((3[0-1])|([1-2][0-9])|(0?[1-9])))|((1[0-2]|(0?[7-9]))\/(30|([1-2][0-9])|(0?[1-9]))))$/.test( value );
}, $.validator.messages.date );

/**
 * Return true, if the value is a valid date, also making this formal check dd/mm/yyyy.
 *
 * @example $.validator.methods.date("01/01/1900")
 * @result true
 *
 * @example $.validator.methods.date("01/13/1990")
 * @result false
 *
 * @example $.validator.methods.date("01.01.1900")
 * @result false
 *
 * @example <input name="pippo" class="{dateITA:true}" />
 * @desc Declares an optional input element whose value must be a valid date.
 *
 * @name $.validator.methods.dateITA
 * @type Boolean
 * @cat Plugins/Validate/Methods
 */
$.validator.addMethod( "dateITA", function( value, element ) {
	var check = false,
		re = /^\d{1,2}\/\d{1,2}\/\d{4}$/,
		adata, gg, mm, aaaa, xdata;
	if ( re.test( value ) ) {
		adata = value.split( "/" );
		gg = parseInt( adata[ 0 ], 10 );
		mm = parseInt( adata[ 1 ], 10 );
		aaaa = parseInt( adata[ 2 ], 10 );
		xdata = new Date( Date.UTC( aaaa, mm - 1, gg, 12, 0, 0, 0 ) );
		if ( ( xdata.getUTCFullYear() === aaaa ) && ( xdata.getUTCMonth() === mm - 1 ) && ( xdata.getUTCDate() === gg ) ) {
			check = true;
		} else {
			check = false;
		}
	} else {
		check = false;
	}
	return this.optional( element ) || check;
}, $.validator.messages.date );

$.validator.addMethod( "dateNL", function( value, element ) {
	return this.optional( element ) || /^(0?[1-9]|[12]\d|3[01])[\.\/\-](0?[1-9]|1[012])[\.\/\-]([12]\d)?(\d\d)$/.test( value );
}, $.validator.messages.date );

// Older "accept" file extension method. Old docs: http://docs.jquery.com/Plugins/Validation/Methods/accept
$.validator.addMethod( "extension", function( value, element, param ) {
	param = typeof param === "string" ? param.replace( /,/g, "|" ) : "png|jpe?g|gif";
	return this.optional( element ) || value.match( new RegExp( "\\.(" + param + ")$", "i" ) );
}, $.validator.format( "Please enter a value with a valid extension." ) );

/**
 * Dutch giro account numbers (not bank numbers) have max 7 digits
 */
$.validator.addMethod( "giroaccountNL", function( value, element ) {
	return this.optional( element ) || /^[0-9]{1,7}$/.test( value );
}, "Please specify a valid giro account number" );

/**
 * IBAN is the international bank account number.
 * It has a country - specific format, that is checked here too
 *
 * Validation is case-insensitive. Please make sure to normalize input yourself.
 */
$.validator.addMethod( "iban", function( value, element ) {

	// Some quick simple tests to prevent needless work
	if ( this.optional( element ) ) {
		return true;
	}

	// Remove spaces and to upper case
	var iban = value.replace( / /g, "" ).toUpperCase(),
		ibancheckdigits = "",
		leadingZeroes = true,
		cRest = "",
		cOperator = "",
		countrycode, ibancheck, charAt, cChar, bbanpattern, bbancountrypatterns, ibanregexp, i, p;

	// Check the country code and find the country specific format
	countrycode = iban.substring( 0, 2 );
	bbancountrypatterns = {
		"AL": "\\d{8}[\\dA-Z]{16}",
		"AD": "\\d{8}[\\dA-Z]{12}",
		"AT": "\\d{16}",
		"AZ": "[\\dA-Z]{4}\\d{20}",
		"BE": "\\d{12}",
		"BH": "[A-Z]{4}[\\dA-Z]{14}",
		"BA": "\\d{16}",
		"BR": "\\d{23}[A-Z][\\dA-Z]",
		"BG": "[A-Z]{4}\\d{6}[\\dA-Z]{8}",
		"CR": "\\d{17}",
		"HR": "\\d{17}",
		"CY": "\\d{8}[\\dA-Z]{16}",
		"CZ": "\\d{20}",
		"DK": "\\d{14}",
		"DO": "[A-Z]{4}\\d{20}",
		"EE": "\\d{16}",
		"FO": "\\d{14}",
		"FI": "\\d{14}",
		"FR": "\\d{10}[\\dA-Z]{11}\\d{2}",
		"GE": "[\\dA-Z]{2}\\d{16}",
		"DE": "\\d{18}",
		"GI": "[A-Z]{4}[\\dA-Z]{15}",
		"GR": "\\d{7}[\\dA-Z]{16}",
		"GL": "\\d{14}",
		"GT": "[\\dA-Z]{4}[\\dA-Z]{20}",
		"HU": "\\d{24}",
		"IS": "\\d{22}",
		"IE": "[\\dA-Z]{4}\\d{14}",
		"IL": "\\d{19}",
		"IT": "[A-Z]\\d{10}[\\dA-Z]{12}",
		"KZ": "\\d{3}[\\dA-Z]{13}",
		"KW": "[A-Z]{4}[\\dA-Z]{22}",
		"LV": "[A-Z]{4}[\\dA-Z]{13}",
		"LB": "\\d{4}[\\dA-Z]{20}",
		"LI": "\\d{5}[\\dA-Z]{12}",
		"LT": "\\d{16}",
		"LU": "\\d{3}[\\dA-Z]{13}",
		"MK": "\\d{3}[\\dA-Z]{10}\\d{2}",
		"MT": "[A-Z]{4}\\d{5}[\\dA-Z]{18}",
		"MR": "\\d{23}",
		"MU": "[A-Z]{4}\\d{19}[A-Z]{3}",
		"MC": "\\d{10}[\\dA-Z]{11}\\d{2}",
		"MD": "[\\dA-Z]{2}\\d{18}",
		"ME": "\\d{18}",
		"NL": "[A-Z]{4}\\d{10}",
		"NO": "\\d{11}",
		"PK": "[\\dA-Z]{4}\\d{16}",
		"PS": "[\\dA-Z]{4}\\d{21}",
		"PL": "\\d{24}",
		"PT": "\\d{21}",
		"RO": "[A-Z]{4}[\\dA-Z]{16}",
		"SM": "[A-Z]\\d{10}[\\dA-Z]{12}",
		"SA": "\\d{2}[\\dA-Z]{18}",
		"RS": "\\d{18}",
		"SK": "\\d{20}",
		"SI": "\\d{15}",
		"ES": "\\d{20}",
		"SE": "\\d{20}",
		"CH": "\\d{5}[\\dA-Z]{12}",
		"TN": "\\d{20}",
		"TR": "\\d{5}[\\dA-Z]{17}",
		"AE": "\\d{3}\\d{16}",
		"GB": "[A-Z]{4}\\d{14}",
		"VG": "[\\dA-Z]{4}\\d{16}"
	};

	bbanpattern = bbancountrypatterns[ countrycode ];

	// As new countries will start using IBAN in the
	// future, we only check if the countrycode is known.
	// This prevents false negatives, while almost all
	// false positives introduced by this, will be caught
	// by the checksum validation below anyway.
	// Strict checking should return FALSE for unknown
	// countries.
	if ( typeof bbanpattern !== "undefined" ) {
		ibanregexp = new RegExp( "^[A-Z]{2}\\d{2}" + bbanpattern + "$", "" );
		if ( !( ibanregexp.test( iban ) ) ) {
			return false; // Invalid country specific format
		}
	}

	// Now check the checksum, first convert to digits
	ibancheck = iban.substring( 4, iban.length ) + iban.substring( 0, 4 );
	for ( i = 0; i < ibancheck.length; i++ ) {
		charAt = ibancheck.charAt( i );
		if ( charAt !== "0" ) {
			leadingZeroes = false;
		}
		if ( !leadingZeroes ) {
			ibancheckdigits += "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".indexOf( charAt );
		}
	}

	// Calculate the result of: ibancheckdigits % 97
	for ( p = 0; p < ibancheckdigits.length; p++ ) {
		cChar = ibancheckdigits.charAt( p );
		cOperator = "" + cRest + "" + cChar;
		cRest = cOperator % 97;
	}
	return cRest === 1;
}, "Please specify a valid IBAN" );

$.validator.addMethod( "integer", function( value, element ) {
	return this.optional( element ) || /^-?\d+$/.test( value );
}, "A positive or negative non-decimal number please" );

$.validator.addMethod( "ipv4", function( value, element ) {
	return this.optional( element ) || /^(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)$/i.test( value );
}, "Please enter a valid IP v4 address." );

$.validator.addMethod( "ipv6", function( value, element ) {
	return this.optional( element ) || /^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))$/i.test( value );
}, "Please enter a valid IP v6 address." );

$.validator.addMethod( "lettersonly", function( value, element ) {
	return this.optional( element ) || /^[a-z]+$/i.test( value );
}, "Letters only please" );

$.validator.addMethod( "letterswithbasicpunc", function( value, element ) {
	return this.optional( element ) || /^[a-z\-.,()'"\s]+$/i.test( value );
}, "Letters or punctuation only please" );

$.validator.addMethod( "mobileNL", function( value, element ) {
	return this.optional( element ) || /^((\+|00(\s|\s?\-\s?)?)31(\s|\s?\-\s?)?(\(0\)[\-\s]?)?|0)6((\s|\s?\-\s?)?[0-9]){8}$/.test( value );
}, "Please specify a valid mobile number" );

/* For UK phone functions, do the following server side processing:
 * Compare original input with this RegEx pattern:
 * ^\(?(?:(?:00\)?[\s\-]?\(?|\+)(44)\)?[\s\-]?\(?(?:0\)?[\s\-]?\(?)?|0)([1-9]\d{1,4}\)?[\s\d\-]+)$
 * Extract $1 and set $prefix to '+44<space>' if $1 is '44', otherwise set $prefix to '0'
 * Extract $2 and remove hyphens, spaces and parentheses. Phone number is combined $prefix and $2.
 * A number of very detailed GB telephone number RegEx patterns can also be found at:
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 */
$.validator.addMethod( "mobileUK", function( phone_number, element ) {
	phone_number = phone_number.replace( /\(|\)|\s+|-/g, "" );
	return this.optional( element ) || phone_number.length > 9 &&
		phone_number.match( /^(?:(?:(?:00\s?|\+)44\s?|0)7(?:[1345789]\d{2}|624)\s?\d{3}\s?\d{3})$/ );
}, "Please specify a valid mobile number" );

/*
 * The número de identidad de extranjero ( NIE )is a code used to identify the non-nationals in Spain
 */
$.validator.addMethod( "nieES", function( value ) {
	"use strict";

	value = value.toUpperCase();

	// Basic format test
	if ( !value.match( "((^[A-Z]{1}[0-9]{7}[A-Z0-9]{1}$|^[T]{1}[A-Z0-9]{8}$)|^[0-9]{8}[A-Z]{1}$)" ) ) {
		return false;
	}

	// Test NIE
	//T
	if ( /^[T]{1}/.test( value ) ) {
		return ( value[ 8 ] === /^[T]{1}[A-Z0-9]{8}$/.test( value ) );
	}

	//XYZ
	if ( /^[XYZ]{1}/.test( value ) ) {
		return (
			value[ 8 ] === "TRWAGMYFPDXBNJZSQVHLCKE".charAt(
				value.replace( "X", "0" )
					.replace( "Y", "1" )
					.replace( "Z", "2" )
					.substring( 0, 8 ) % 23
			)
		);
	}

	return false;

}, "Please specify a valid NIE number." );

/*
 * The Número de Identificación Fiscal ( NIF ) is the way tax identification used in Spain for individuals
 */
$.validator.addMethod( "nifES", function( value ) {
	"use strict";

	value = value.toUpperCase();

	// Basic format test
	if ( !value.match( "((^[A-Z]{1}[0-9]{7}[A-Z0-9]{1}$|^[T]{1}[A-Z0-9]{8}$)|^[0-9]{8}[A-Z]{1}$)" ) ) {
		return false;
	}

	// Test NIF
	if ( /^[0-9]{8}[A-Z]{1}$/.test( value ) ) {
		return ( "TRWAGMYFPDXBNJZSQVHLCKE".charAt( value.substring( 8, 0 ) % 23 ) === value.charAt( 8 ) );
	}

	// Test specials NIF (starts with K, L or M)
	if ( /^[KLM]{1}/.test( value ) ) {
		return ( value[ 8 ] === String.fromCharCode( 64 ) );
	}

	return false;

}, "Please specify a valid NIF number." );

jQuery.validator.addMethod( "notEqualTo", function( value, element, param ) {
	return this.optional( element ) || !$.validator.methods.equalTo.call( this, value, element, param );
}, "Please enter a different value, values must not be the same." );

$.validator.addMethod( "nowhitespace", function( value, element ) {
	return this.optional( element ) || /^\S+$/i.test( value );
}, "No white space please" );

/**
* Return true if the field value matches the given format RegExp
*
* @example $.validator.methods.pattern("AR1004",element,/^AR\d{4}$/)
* @result true
*
* @example $.validator.methods.pattern("BR1004",element,/^AR\d{4}$/)
* @result false
*
* @name $.validator.methods.pattern
* @type Boolean
* @cat Plugins/Validate/Methods
*/
$.validator.addMethod( "pattern", function( value, element, param ) {
	if ( this.optional( element ) ) {
		return true;
	}
	if ( typeof param === "string" ) {
		param = new RegExp( "^(?:" + param + ")$" );
	}
	return param.test( value );
}, "Invalid format." );

/**
 * Dutch phone numbers have 10 digits (or 11 and start with +31).
 */
$.validator.addMethod( "phoneNL", function( value, element ) {
	return this.optional( element ) || /^((\+|00(\s|\s?\-\s?)?)31(\s|\s?\-\s?)?(\(0\)[\-\s]?)?|0)[1-9]((\s|\s?\-\s?)?[0-9]){8}$/.test( value );
}, "Please specify a valid phone number." );

/* For UK phone functions, do the following server side processing:
 * Compare original input with this RegEx pattern:
 * ^\(?(?:(?:00\)?[\s\-]?\(?|\+)(44)\)?[\s\-]?\(?(?:0\)?[\s\-]?\(?)?|0)([1-9]\d{1,4}\)?[\s\d\-]+)$
 * Extract $1 and set $prefix to '+44<space>' if $1 is '44', otherwise set $prefix to '0'
 * Extract $2 and remove hyphens, spaces and parentheses. Phone number is combined $prefix and $2.
 * A number of very detailed GB telephone number RegEx patterns can also be found at:
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 */
$.validator.addMethod( "phoneUK", function( phone_number, element ) {
	phone_number = phone_number.replace( /\(|\)|\s+|-/g, "" );
	return this.optional( element ) || phone_number.length > 9 &&
		phone_number.match( /^(?:(?:(?:00\s?|\+)44\s?)|(?:\(?0))(?:\d{2}\)?\s?\d{4}\s?\d{4}|\d{3}\)?\s?\d{3}\s?\d{3,4}|\d{4}\)?\s?(?:\d{5}|\d{3}\s?\d{3})|\d{5}\)?\s?\d{4,5})$/ );
}, "Please specify a valid phone number" );

/**
 * Matches US phone number format
 *
 * where the area code may not start with 1 and the prefix may not start with 1
 * allows '-' or ' ' as a separator and allows parens around area code
 * some people may want to put a '1' in front of their number
 *
 * 1(212)-999-2345 or
 * 212 999 2344 or
 * 212-999-0983
 *
 * but not
 * 111-123-5434
 * and not
 * 212 123 4567
 */
$.validator.addMethod( "phoneUS", function( phone_number, element ) {
	phone_number = phone_number.replace( /\s+/g, "" );
	return this.optional( element ) || phone_number.length > 9 &&
		phone_number.match( /^(\+?1-?)?(\([2-9]([02-9]\d|1[02-9])\)|[2-9]([02-9]\d|1[02-9]))-?[2-9]([02-9]\d|1[02-9])-?\d{4}$/ );
}, "Please specify a valid phone number" );

/* For UK phone functions, do the following server side processing:
 * Compare original input with this RegEx pattern:
 * ^\(?(?:(?:00\)?[\s\-]?\(?|\+)(44)\)?[\s\-]?\(?(?:0\)?[\s\-]?\(?)?|0)([1-9]\d{1,4}\)?[\s\d\-]+)$
 * Extract $1 and set $prefix to '+44<space>' if $1 is '44', otherwise set $prefix to '0'
 * Extract $2 and remove hyphens, spaces and parentheses. Phone number is combined $prefix and $2.
 * A number of very detailed GB telephone number RegEx patterns can also be found at:
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 */

// Matches UK landline + mobile, accepting only 01-3 for landline or 07 for mobile to exclude many premium numbers
$.validator.addMethod( "phonesUK", function( phone_number, element ) {
	phone_number = phone_number.replace( /\(|\)|\s+|-/g, "" );
	return this.optional( element ) || phone_number.length > 9 &&
		phone_number.match( /^(?:(?:(?:00\s?|\+)44\s?|0)(?:1\d{8,9}|[23]\d{9}|7(?:[1345789]\d{8}|624\d{6})))$/ );
}, "Please specify a valid uk phone number" );

/**
 * Matches a valid Canadian Postal Code
 *
 * @example jQuery.validator.methods.postalCodeCA( "H0H 0H0", element )
 * @result true
 *
 * @example jQuery.validator.methods.postalCodeCA( "H0H0H0", element )
 * @result false
 *
 * @name jQuery.validator.methods.postalCodeCA
 * @type Boolean
 * @cat Plugins/Validate/Methods
 */
$.validator.addMethod( "postalCodeCA", function( value, element ) {
	return this.optional( element ) || /^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ] *\d[ABCEGHJKLMNPRSTVWXYZ]\d$/i.test( value );
}, "Please specify a valid postal code" );

/*
* Valida CEPs do brasileiros:
*
* Formatos aceitos:
* 99999-999
* 99.999-999
* 99999999
*/
$.validator.addMethod( "postalcodeBR", function( cep_value, element ) {
	return this.optional( element ) || /^\d{2}.\d{3}-\d{3}?$|^\d{5}-?\d{3}?$/.test( cep_value );
}, "Informe um CEP válido." );

/* Matches Italian postcode (CAP) */
$.validator.addMethod( "postalcodeIT", function( value, element ) {
	return this.optional( element ) || /^\d{5}$/.test( value );
}, "Please specify a valid postal code" );

$.validator.addMethod( "postalcodeNL", function( value, element ) {
	return this.optional( element ) || /^[1-9][0-9]{3}\s?[a-zA-Z]{2}$/.test( value );
}, "Please specify a valid postal code" );

// Matches UK postcode. Does not match to UK Channel Islands that have their own postcodes (non standard UK)
$.validator.addMethod( "postcodeUK", function( value, element ) {
	return this.optional( element ) || /^((([A-PR-UWYZ][0-9])|([A-PR-UWYZ][0-9][0-9])|([A-PR-UWYZ][A-HK-Y][0-9])|([A-PR-UWYZ][A-HK-Y][0-9][0-9])|([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))\s?([0-9][ABD-HJLNP-UW-Z]{2})|(GIR)\s?(0AA))$/i.test( value );
}, "Please specify a valid UK postcode" );

/*
 * Lets you say "at least X inputs that match selector Y must be filled."
 *
 * The end result is that neither of these inputs:
 *
 *	<input class="productinfo" name="partnumber">
 *	<input class="productinfo" name="description">
 *
 *	...will validate unless at least one of them is filled.
 *
 * partnumber:	{require_from_group: [1,".productinfo"]},
 * description: {require_from_group: [1,".productinfo"]}
 *
 * options[0]: number of fields that must be filled in the group
 * options[1]: CSS selector that defines the group of conditionally required fields
 */
$.validator.addMethod( "require_from_group", function( value, element, options ) {
	var $fields = $( options[ 1 ], element.form ),
		$fieldsFirst = $fields.eq( 0 ),
		validator = $fieldsFirst.data( "valid_req_grp" ) ? $fieldsFirst.data( "valid_req_grp" ) : $.extend( {}, this ),
		isValid = $fields.filter( function() {
			return validator.elementValue( this );
		} ).length >= options[ 0 ];

	// Store the cloned validator for future validation
	$fieldsFirst.data( "valid_req_grp", validator );

	// If element isn't being validated, run each require_from_group field's validation rules
	if ( !$( element ).data( "being_validated" ) ) {
		$fields.data( "being_validated", true );
		$fields.each( function() {
			validator.element( this );
		} );
		$fields.data( "being_validated", false );
	}
	return isValid;
}, $.validator.format( "Please fill at least {0} of these fields." ) );

/*
 * Lets you say "either at least X inputs that match selector Y must be filled,
 * OR they must all be skipped (left blank)."
 *
 * The end result, is that none of these inputs:
 *
 *	<input class="productinfo" name="partnumber">
 *	<input class="productinfo" name="description">
 *	<input class="productinfo" name="color">
 *
 *	...will validate unless either at least two of them are filled,
 *	OR none of them are.
 *
 * partnumber:	{skip_or_fill_minimum: [2,".productinfo"]},
 * description: {skip_or_fill_minimum: [2,".productinfo"]},
 * color:		{skip_or_fill_minimum: [2,".productinfo"]}
 *
 * options[0]: number of fields that must be filled in the group
 * options[1]: CSS selector that defines the group of conditionally required fields
 *
 */
$.validator.addMethod( "skip_or_fill_minimum", function( value, element, options ) {
	var $fields = $( options[ 1 ], element.form ),
		$fieldsFirst = $fields.eq( 0 ),
		validator = $fieldsFirst.data( "valid_skip" ) ? $fieldsFirst.data( "valid_skip" ) : $.extend( {}, this ),
		numberFilled = $fields.filter( function() {
			return validator.elementValue( this );
		} ).length,
		isValid = numberFilled === 0 || numberFilled >= options[ 0 ];

	// Store the cloned validator for future validation
	$fieldsFirst.data( "valid_skip", validator );

	// If element isn't being validated, run each skip_or_fill_minimum field's validation rules
	if ( !$( element ).data( "being_validated" ) ) {
		$fields.data( "being_validated", true );
		$fields.each( function() {
			validator.element( this );
		} );
		$fields.data( "being_validated", false );
	}
	return isValid;
}, $.validator.format( "Please either skip these fields or fill at least {0} of them." ) );

/* Validates US States and/or Territories by @jdforsythe
 * Can be case insensitive or require capitalization - default is case insensitive
 * Can include US Territories or not - default does not
 * Can include US Military postal abbreviations (AA, AE, AP) - default does not
 *
 * Note: "States" always includes DC (District of Colombia)
 *
 * Usage examples:
 *
 *  This is the default - case insensitive, no territories, no military zones
 *  stateInput: {
 *     caseSensitive: false,
 *     includeTerritories: false,
 *     includeMilitary: false
 *  }
 *
 *  Only allow capital letters, no territories, no military zones
 *  stateInput: {
 *     caseSensitive: false
 *  }
 *
 *  Case insensitive, include territories but not military zones
 *  stateInput: {
 *     includeTerritories: true
 *  }
 *
 *  Only allow capital letters, include territories and military zones
 *  stateInput: {
 *     caseSensitive: true,
 *     includeTerritories: true,
 *     includeMilitary: true
 *  }
 *
 */
$.validator.addMethod( "stateUS", function( value, element, options ) {
	var isDefault = typeof options === "undefined",
		caseSensitive = ( isDefault || typeof options.caseSensitive === "undefined" ) ? false : options.caseSensitive,
		includeTerritories = ( isDefault || typeof options.includeTerritories === "undefined" ) ? false : options.includeTerritories,
		includeMilitary = ( isDefault || typeof options.includeMilitary === "undefined" ) ? false : options.includeMilitary,
		regex;

	if ( !includeTerritories && !includeMilitary ) {
		regex = "^(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|PA|RI|S[CD]|T[NX]|UT|V[AT]|W[AIVY])$";
	} else if ( includeTerritories && includeMilitary ) {
		regex = "^(A[AEKLPRSZ]|C[AOT]|D[CE]|FL|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEINOPST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])$";
	} else if ( includeTerritories ) {
		regex = "^(A[KLRSZ]|C[AOT]|D[CE]|FL|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEINOPST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])$";
	} else {
		regex = "^(A[AEKLPRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|PA|RI|S[CD]|T[NX]|UT|V[AT]|W[AIVY])$";
	}

	regex = caseSensitive ? new RegExp( regex ) : new RegExp( regex, "i" );
	return this.optional( element ) || regex.test( value );
}, "Please specify a valid state" );

// TODO check if value starts with <, otherwise don't try stripping anything
$.validator.addMethod( "strippedminlength", function( value, element, param ) {
	return $( value ).text().length >= param;
}, $.validator.format( "Please enter at least {0} characters" ) );

$.validator.addMethod( "time", function( value, element ) {
	return this.optional( element ) || /^([01]\d|2[0-3]|[0-9])(:[0-5]\d){1,2}$/.test( value );
}, "Please enter a valid time, between 00:00 and 23:59" );

$.validator.addMethod( "time12h", function( value, element ) {
	return this.optional( element ) || /^((0?[1-9]|1[012])(:[0-5]\d){1,2}(\ ?[AP]M))$/i.test( value );
}, "Please enter a valid time in 12-hour am/pm format" );

// Same as url, but TLD is optional
$.validator.addMethod( "url2", function( value, element ) {
	return this.optional( element ) || /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)*(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test( value );
}, $.validator.messages.url );

/**
 * Return true, if the value is a valid vehicle identification number (VIN).
 *
 * Works with all kind of text inputs.
 *
 * @example <input type="text" size="20" name="VehicleID" class="{required:true,vinUS:true}" />
 * @desc Declares a required input element whose value must be a valid vehicle identification number.
 *
 * @name $.validator.methods.vinUS
 * @type Boolean
 * @cat Plugins/Validate/Methods
 */
$.validator.addMethod( "vinUS", function( v ) {
	if ( v.length !== 17 ) {
		return false;
	}

	var LL = [ "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ],
		VL = [ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 7, 9, 2, 3, 4, 5, 6, 7, 8, 9 ],
		FL = [ 8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2 ],
		rs = 0,
		i, n, d, f, cd, cdv;

	for ( i = 0; i < 17; i++ ) {
		f = FL[ i ];
		d = v.slice( i, i + 1 );
		if ( i === 8 ) {
			cdv = d;
		}
		if ( !isNaN( d ) ) {
			d *= f;
		} else {
			for ( n = 0; n < LL.length; n++ ) {
				if ( d.toUpperCase() === LL[ n ] ) {
					d = VL[ n ];
					d *= f;
					if ( isNaN( cdv ) && n === 8 ) {
						cdv = LL[ n ];
					}
					break;
				}
			}
		}
		rs += d;
	}
	cd = rs % 11;
	if ( cd === 10 ) {
		cd = "X";
	}
	if ( cd === cdv ) {
		return true;
	}
	return false;
}, "The specified vehicle identification number (VIN) is invalid." );

$.validator.addMethod( "zipcodeUS", function( value, element ) {
	return this.optional( element ) || /^\d{5}(-\d{4})?$/.test( value );
}, "The specified US ZIP Code is invalid" );

$.validator.addMethod( "ziprange", function( value, element ) {
	return this.optional( element ) || /^90[2-5]\d\{2\}-\d{4}$/.test( value );
}, "Your ZIP-code must be in the range 902xx-xxxx to 905xx-xxxx" );

}));
/** =============================自定义额外方法=============================================== */
/**
 * 判断数组是否包含某个值
 * @param e
 * @returns {boolean}
 */
function isInArray(v, a) {
	for(i=0;i<a.length && a[i]!=v;i++);
	return !(i==a.length);
}
/**
 * 计算周岁 （larry 20160311用于年龄控制的下限）
 * @param strBirthday 1991-01-01
 * @returns {*}
 * -2：参数日期为空
 * -1：表示出生日期输入错误 晚于今天
 * 其他值：年龄
 */
function calAge(strBirthday) {

	var returnAge;
	if(strBirthday==null || strBirthday == "")
	{
		returnAge=-2;
		return returnAge;
	}
	var strBirthdayArr = strBirthday.split("-");
	var birthYear = parseInt(strBirthdayArr[0]);
	var birthMonth = parseInt(strBirthdayArr[1]);
	var birthDay = parseInt(strBirthdayArr[2]);
	var d = new Date();
	var nowYear = d.getFullYear();
	var nowMonth = d.getMonth() + 1;
	var nowDay = d.getDate();

	if (nowYear == birthYear) {
		returnAge = 0;//同年 则为0岁
	} else {
		var ageDiff = nowYear - birthYear; //年之差
		if (ageDiff > 0) {
			if (nowMonth == birthMonth) {
				var dayDiff = nowDay - birthDay;//日之差
				if (dayDiff < 0) {
					returnAge = ageDiff - 1;
				} else {
					returnAge = ageDiff;
				}
			} else {
				var monthDiff = nowMonth - birthMonth;//月之差
				if (monthDiff < 0) {
					returnAge = ageDiff - 1;
				} else {
					returnAge = ageDiff;
				}
			}
		} else {
			returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
		}
	}
	return returnAge;//返回周岁年龄

}

/**
 * 计算虚岁（larry 20160311用于年龄控制的上限）
 * @param strBirthday 2016-03-11
 * @returns {*}
 *  -2：参数日期为空
 * -1：表示出生日期输入错误 晚于今天
 * 其他值：年龄
 */
function calCHNAge(strBirthday) {

	var returnAge;
	if(strBirthday==null || strBirthday == "")
	{
		returnAge=-2;
		return returnAge;
	}
	var strBirthdayArr = strBirthday.split("-");
	var birthYear = parseInt(strBirthdayArr[0]);
	var birthMonth = parseInt(strBirthdayArr[1]);
	var birthDay = parseInt(strBirthdayArr[2]);
	var d = new Date();
	var nowYear = d.getFullYear();
	var nowMonth = d.getMonth() + 1;
	var nowDay = d.getDate();

	if (nowYear == birthYear) {
		if(nowMonth==birthMonth && nowDay==birthDay)
		{
			returnAge = 0;//刚出生那天 则为0岁
		}else{
			returnAge = 1;
		}
	} else {
		var ageDiff = nowYear - birthYear; //年之差
		if (ageDiff > 0) {
			if (nowMonth == birthMonth) {
				var dayDiff = nowDay - birthDay;//日之差
				if (dayDiff <= 0) {
					returnAge = ageDiff;
				} else {
					returnAge = ageDiff+1;
				}
			} else {
				var monthDiff = nowMonth - birthMonth;//月之差
				if (monthDiff < 0) {
					returnAge = ageDiff;
				} else {
					returnAge = ageDiff+1;
				}
			}
		} else {
			returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
		}
	}
	return returnAge;//返回虚岁年龄

}
/**
 * 公用函数，身份证校验
 * @param idNumber
 * @returns {boolean}
 */
function isIdCardNo(idNumber) {
	var checkDate = function(RQ){
		var date = RQ;
		var result = date.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
//        console.debug("isIdCardNo-result: %o", result);
		if (result == null)
			return false;
		var d = new Date(result[1], result[3] - 1, result[4]);
//        console.debug("isIdCardNo-d: %o", d);
//        console.debug("isIdCardNo-return: %o", (d.getFullYear() == result[1] && (d.getMonth() + 1) == result[3] && d.getDate() == result[4]));

		return (d.getFullYear() == result[1] && (d.getMonth() + 1) == result[3] && d.getDate() == result[4]);
	}
	var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
	var varArray = new Array();
	var lngProduct = 0;
	var intCheckDigit;
	// var idNumber.length = ;

	if ((idNumber.length != 15) && (idNumber.length != 18)) {
		return false;
	}
	for (i = 0; i < idNumber.length; i++) {
		varArray[i] = idNumber.charAt(i);
		if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
			return false;
		} else if (i < 17) {
			varArray[i] = varArray[i] * factorArr[i];
		}
	}
	if (idNumber.length == 18) {
//        var date8 = idNumber.substring(6, 14);
		var date8 = idNumber.substring(6, 10)+"-"+idNumber.substring(10, 12)+"-"+idNumber.substring(12, 14);
//        console.debug(checkDate(date8));
		if (checkDate(date8) == false) {
			return false;
		}
		for (i = 0; i < 17; i++) {
			lngProduct = lngProduct + varArray[i];
		}
		intCheckDigit = 12 - (lngProduct % 11);
		switch (intCheckDigit) {
			case 10:
				intCheckDigit = 'X';
				break;
			case 11:
				intCheckDigit = 0;
				break;
			case 12:
				intCheckDigit = 1;
				break;
		}
		if (varArray[17].toUpperCase() != intCheckDigit) {
			return false;
		}
	} else {
		var date6 = "19"+idNumber.substring(6, 8)+"-"+idNumber.substring(8, 10)+"-"+idNumber.substring(10, 12);
		if (checkDate(date6) == false) {
			return false;
		}
	}
	return true;
}

/**
 * 验证车牌号
 *20160615 鼎和二期有的地方会将车牌号拆分，所以在监测信息的时候，判断是否有拆分项，如果有，就先拼接再校验.
 * @param plateNo
 * @returns {Boolean}
 */
function validatePlateNo(plateNo){
	var per = /^[京津沪渝蒙新藏桂黑吉辽冀晋青鲁豫苏皖浙闽赣湘鄂粤琼甘陕川贵云宁]{1}[A-Z]{1}[A-Za-z0-9]{5}$/;
	var per1= /^[京]{1}[A-Z]{1}[A-Za-z0-9]{5,6}$/;
	var per2=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;
	var fanti=/^[滬遼晉魯蘇閩贛粵瓊陝貴雲甯]{1}[A-Z]{1}[A-Za-z0-9]{5}$/;
	var per3=/^[京]{1}[A-Z]{1}/;
	var per4= /^[云]{1}[A-AC-HJ-SU-V]{1}[A-Za-z0-9]{5}$/;
	var per5=/^[云]{1}[A-Z]{1}/;
	var per4= /^[豫]{1}[A-HJ-Z]{1}[A-HJ-Za-hj-z0-9]{5}$/;
	var per5=/^[豫]{1}[A-Z]{1}/;
	var isXinOrXu="old"; // 判断是新保还是续保提示信息有区别
	var result = "";

	if(isXinOrXu == "new"){
		result = "您输入的车牌号有误，如果您的车辆尚未上牌，请勾选新车未上牌";
	}else{
		result = "您输入的车牌号有误";
	}
	var car_numspan = $('.car_numspan').text();
	/*
	 alert("car_numspan="+car_numspan);
	 */
	if(car_numspan)
	{
		plateNo = car_numspan+plateNo;
	}
	/*
	 alert(plateNo);
	 */
	if(plateNo.charAt(0)=='L' && plateNo.charAt(1)=='S'){
		$.validator.messages['plateNo']=result;
		return false;
	}else if(per2.test(plateNo) || fanti.test(plateNo)){
		$.validator.messages['plateNo']="您输入的车牌号包含繁体字、特殊字符";
		return false;
	}
	// 如果是京开头的车牌则允许后面多一位车牌号(个性车牌)
	if(per3.test(plateNo)){
		if(!per1.test(plateNo)){
			$.validator.messages['plateNo']=result;
			return false;
		}
	}else if(per5.test(plateNo)){
		if(!per4.test(plateNo)){
			$.validator.messages['plateNo']=result;
			return false;
		}
	}else{
		if(!per.test(plateNo)){
			$.validator.messages['plateNo']=result;
			return false;
		}
	}
	return true;
}

/** 常用的校验正则表达式 */
var regex = {
	mobile: /^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57]|17[0-9])[0-9]{8}$/ ,
	phone400: /^400[0-9]{7}/, // 400电话正则
	phone800: /^800[0-9]{7}/, // 800电话正则
	phone: /^0[0-9]{2,3}-[0-9]{8}/, // 普通固话正则（带区号，020-86511111）
	chinese: /^([\u4E00-\u9FA5\uF900-\uFA2D])*$/,
	passPort: /^[a-zA-Z]\d{8}?$/i,
	numbers: /^\d+$/
};

/* jQuery Validation框架的自定义规则方法 START */
/* 小数验证，小数点位数按照max参数的小数点位数进行判断
 * 不能为空、只能输入数字 */
$.validator.addMethod("isDecimal", function(value, element, params) {
	if(isNaN(params[0])) {
//                console.error("参数错误，decimal验证的min只能为数字");
		return false;
	}
	if(isNaN(params[1])) {
//                console.error("参数错误，decimal验证的max只能为数字");
		return false;
	}

	var acc = params[2];
	if(typeof(acc) == 'undefined' || isNaN(params[2]) || acc == undefined || typeof acc == 'undefined' || acc == 0) {
		params[2] = '的整数';
	} else {
		params[2] = '，最多只保留小数点后'+params[2]+'位的数值'
	}
	if(isNaN(value)) {
		return false;
	}
	if(typeof(value) == 'undefined' || value == "") {
		return false;
	}
	var min = Number(params[0]);
	var max = Number(params[1]);
	var testVal = Number(value);
	if(typeof(acc) == 'undefined' || acc == 0) {
		var regX = /^\d+$/;
	} else {
		var regxStr = "^\\d+(\\.\\d{1,"+acc+"})?$";
		var regX = new RegExp(regxStr);
	}
//		    console.debug("regX: %o, value: %o, test: %o", regX, value, regX.test(value));
	return this.optional(element) || (regX.test(value) && testVal >= min && testVal <= max);
});

/**
 * 身份证校验
 */
jQuery.validator.addMethod("isIdCardNo", function(value, element, params) {
	var flag = false;
	if(isIdCardNo(value)) {
		var minAge = params[0];
		var maxAge = params[1];
		if((!isNaN(minAge) && minAge > 0) || (!isNaN(maxAge) && maxAge > 0)) {
			var title = params[2];
			var birth = value.length == 18 ? value.substring(6, 10)+
			"-"+value.substring(10, 12)+"-"+
			value.substring(12, 14) : "19"+value.substring(6, 8)+"-"+value.substring(8, 10)+"-"+value.substring(10, 12);
			var minAgeMsg = '年满'+minAge+'周岁';
			var maxAgeMsg = '小于'+maxAge+'周岁';
			var msg = title + "必须";
			if(!isNaN(minAge) && minAge > 0) {
				flag = calAge(birth) >= minAge;
				msg += minAgeMsg;
			}

			if(!isNaN(maxAge) && maxAge > 0) {
				flag = flag && calAge(birth) < maxAge;
				msg += maxAgeMsg;
			}

			if(!flag) {
				jQuery.validator.messages['isIdCardNo']=msg;
			}
		} else {
			flag = true;
		}

	} else {
		flag = false;
	}
	return this.optional(element) || flag;
});

/**
 * 手机号验证
 */
jQuery.validator.addMethod("mobilePhone", function(value, element){

	return this.optional(element) || (value.length == 11 && regex.mobile.test(value));
});
/**
 * 验证综合号码（固话+机构400+机构800+手机）
 */
jQuery.validator.addMethod("combimePhone", function(value, element){
	var rs = (value.length == 11 && regex.mobile.test(value)) ||
		regex.phone.test(value) ||
		regex.phone400.test(value) ||
		regex.phone800.test(value);
	return this.optional(element) || rs;
});
/**
 * 中文验证
 */
jQuery.validator.addMethod("isChinese", function(value, element, params){
	//判断是否有最小值
	var lenTest = true
	if(!isNaN(params[0])){
		lenTest = value.length >= params[0]
	}
	if(!isNaN(params[1])) {
		lenTest = lenTest && value.length <= params[1]
	}
	return this.optional(element) || regex.chinese.test(value) && lenTest;
});
/**
 * 车架号格式校验
 */
jQuery.validator.addMethod("frameNoFormat", function(value, element){
	return this.optional(element) || /^[\u4e00-\u9fa5]?[a-zA-Z0-9\*]{1,}$/.test(value);
}, $.validator.format("车架号不应有字母Q,I,O等字符，第一位可以是汉字,请校对修改"));
/**
 * 发动机号格式校验
 */
jQuery.validator.addMethod("engineNoFormat", function(value, element){
	return this.optional(element) || /^[a-zA-Z0-9\*]{1,}$/.test(value);
}, $.validator.format("发动号不应有字母Q,I,O等字符，第一位不可以是汉字,请校对修改"));

/**
 * 海南新车未上牌校验发动机号 规则： “发”+ 发动机后六位
 */
jQuery.validator.addMethod("specialEngineNoFormat", function(value, element){
	var car_numspanV = $(".car_numspan").text();
	if(car_numspanV)
	{
		value = car_numspanV + value;
	}
	var valueBer =  value.substring(0,1);
	var valueMini = value.substring(1,value.length);
	return this.optional(element) || ( "发"== valueBer && /^[a-zA-Z0-9\*]{1,}$/.test(valueMini) );
}, $.validator.format("请填写正确的车牌号。该地区的新车未上牌，车牌号填写规则为“发”+ 发动机后六位"));

/**
 * 不能包含的字符/字符串
 */
jQuery.validator.addMethod("excludeStr", function(value, element, params) {
	var f = true;
	var p = params.split(",")
	value = value.toUpperCase();
	for(var i=0; i < p.length; i++) {
		if(value.indexOf(p[i]) >= 0) {
			f = false;
			break;
		}
	}
	return (this.optional(element) || f);
}, $.validator.format("录入信息中不能包括：{0}等字符"));

/**
 * 不能包含的字符/字符串
 */
jQuery.validator.addMethod("excludeStrYN", function(value, element, params) {
	var f = true;
	var p = params.split(",")
	value = value.toUpperCase();
	for(var i=0; i < p.length; i++) {
		if(value.indexOf(p[i]) >= 0) {
			f = false;
			break;
		}
	}
	return (this.optional(element) || f);
}, $.validator.format("请核实车牌号"));

/**
 * 不能包含"*"号
 */
jQuery.validator.addMethod("excludeStarNell", function(value, element, params) {
	var f = true;
	var p = params.split(",")
	for(var i=0; i < p.length; i++) {
		if(value.indexOf(p[i]) >= 0) {
			f = false;
			break;
		}
	}
	return (this.optional(element) || f);
}, $.validator.format("录入信息中不能包括：{0}等字符"));

/**
 * 客户姓名录入
 */
jQuery.validator.addMethod("isValidName", function(value, element){
	if(regex.chinese.test(value)){
		/* 纯中文 */
		return this.optional(element) || value.length >= 2 && value.length <= 15;
	} else if(/^[a-z]+$/.test(value.toLowerCase())) {
		/* 纯英文 */
		return this.optional(element) || value.length >= 4 && value.length <= 30;
	} else {
		return this.optional(element) || false;
	}
}, $.validator.format("姓名不合法！"));

/**
 * 车主姓名校验
 */
jQuery.validator.addMethod("isCarOwnerName", function (value, element) {
	var keyWords = ["运输", "储运", "物流", "出租", "租赁", "货运", "搬家", "汽车服务公司", "客运服务公司",
		"旅行社", "旅游服务公司", "公司"];
	for (var i = 0; i < keyWords.length; i++) {
		if (value.indexOf(keyWords[i]) != -1) {
			return false;
		}
	}
	return true;
});

/**
 * 发动机号校验
 */
jQuery.validator.addMethod("isEngineNo",function(value, element, params) {
	var per=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;
	var f = params;
	if(per.test(value))
	{
		f = false;
	}
	if (value.indexOf(" ") >= 0) {
		f = false;
	}
	return (this.optional(element) || f);
}, $.validator.format("您的输入包含空格或特殊字符"));

/**
 * 车牌号校验
 */
jQuery.validator.addMethod("isLicenseNo", function(value, element){
	return this.optional(element) || validatePlateNo(value);
});
/**
 * 车牌号校验
 */
jQuery.validator.addMethod("isLicenseNo_nocb", function(value, element){
	return this.optional(element) || validatePlateNo(value);
});

/**
 * 值限定校验
 */
jQuery.validator.addMethod("isInList", function(value, element, params){
	var flag = false;
	if(value == '' || typeof value == 'undefined') {
		flag = false;
	} else {
		var arr = params[0];
//                console.debug("params: %o, test: %o", params, isInArray(value, arr));
		isInArray(value, arr);
		flag = true;
	}

	return this.optional(element) || flag;
}, $.validator.format("输入值必须是${0}其中之一。"));

/**
 * 纳税人识别号
 * 编码规则
 * 已领取组织机构代码的纳税人税务登记代码为：区域码+国家技术监督部门设定纳税人识别号,一律由15位、18或者20位码(字符型)组成
 * 其中：
 *     企业、事业单位等组织机构纳税人，以国家技术监督局编制的9位码(其中区分主码位与校验位之间的“-”符省略不打印)并在其前面加挂6位行政区划码共15位码，作为其“纳税人识别号”。
 *     国家税务总局下达的纳税人代码为15位，其中：1—2位为省、市代码，3—6位为地区代码，7—8位为经济性质代码，9—10位行业代码，11—15位为各地自设的顺序码。
 *      从事生产、经营的外籍、港、澳、台人员税务登记代码为：区域码+相应的有效证件(如护照，香港、澳门、台湾居民往来大陆通行证等)号码。
 *      个体工商户税务登记代码为其居民身份证号码。
 *      个体工商户和其他缴纳个人所得税的中国公民，以公安部编制的居民身份证18位码为其“纳税人识别号”;
 *      对外国人以其国别加护照号码作为其“纳税人识别号”。
 */
jQuery.validator.addMethod("taxPlayerCode", function(v, e, p) {
	var flag = false;
	var validReg = /^[a-zA-Z0-9]*$/g;
	if(v.length == 15 || v.length == 18 || v.length == 20) {
		flag = validReg.test(v);
	}
	return this.optional(e) || flag;
});

jQuery.validator.addMethod("bankAccount", function(v, e, p) {
	var flag = false;
	var validReg = /^[0-9]*$/g;
	if(v.length >= 16 && v.length <= 19) {
		flag = validReg.test(v);
	}
	return this.optional(e) || flag;
});

/* jQuery Validation框架的自定义规则方法 END */

/* jQuery Validation框架的自定义类规则 START */
$.validator.addClassRules("licenseNo", {
	required: true,
	isLicenseNo: true
});
$.validator.addClassRules("licenseNoHN", {
	required: true,
	excludeStr: "I",
	isLicenseNo: true
});
$.validator.addClassRules("licenseNoYN", {
	required: true,
	excludeStrYN: "云B,云I,云T,云W,云X,云Y,云Z,云b,云i,云t,云w,云x,云y,云z",
	isLicenseNo: true
});

/*20160707 新增海南车 新车未上牌情况下的车牌号校验 ： "发"+发动机后六位 */
$.validator.addClassRules("specialEgineNo", {
	required: true,
	specialEngineNoFormat: true,
	excludeStr: "Q,I,O"
});

$.validator.addClassRules("licenseNo_noIO", {
	required: true,
	excludeStr: "I,O",
	isLicenseNo: true
});
$.validator.addClassRules("licenseNoCanNull", {
	isLicenseNo_nocb: true
});
/* 带精度小数验证 */
$.validator.addClassRules("decimal", {
	isDecimal: function(element){
//			alert($(arg1).parent().html());
		var jqElement = $(element);
		var min = jqElement.attr("min");
		var max = jqElement.attr("max");
		var accuracy = jqElement.attr("accuracy");
		return [min, max, accuracy];
	}
});

/* 身份证 */
$.validator.addClassRules("idcard", {
	isIdCardNo: function(element){
//			alert($(arg1).parent().html());
		var jqElement = $(element);
		var minAge = jqElement.attr("minAge");
		var maxAge = jqElement.attr("maxAge");
//                var accuracy = jqElement.attr("accuracy");
		return [minAge, maxAge, jqElement.attr("msgTitle")];
	},
	required: true
});

/* 纳税人识别号 */
$.validator.addClassRules("taxPlayerCode", {
	taxPlayerCode: true,
	required: true
});

/**
 * 校验身份证
 *
 * @param PPCard
 *            9位数护照证号码
 * @return true：正确
 */
function checkPPCard(v_card) {
	var reg = /^[a-zA-Z]\d{8}?$/i;
	if (!reg.test(v_card)) {
		return false;
	}
	return true;
}

/**
 * 校验身份证
 *
 * @param idCard
 *            15/18位身份证号码
 * @return true：正确
 */
function checkOfCard(v_card) {
	var reg = /^\d{8}?$/i;
	if (!reg.test(v_card)) {
		return false;
	}
	return true;
}
//对护照进行校验
$.validator.addMethod("ppcard",function(value,element){
	return this.optional(element) || checkPPCard(value);
},"护照填写错误");

//对军官证进行校验
$.validator.addMethod("ofcard",function(value,element){
	return this.optional(element) || checkOfCard(value);
},"军官证填写错误");

//对护照进行校验
$.validator.addClassRules("ppcard",{
	required: true,
	ppcard: true,
	minlength: 9,
	maxlength: 9
});

//对军官证进行校验
$.validator.addClassRules("ofcard",{
	required: true,
	ofcard: true,
	minlength: 8,
	maxlength: 8
});

/* 车架号 */
$.validator.addClassRules("frameNo", {
	required: true,
	frameNoFormat: true,
	excludeStr: "I,O,Q",
	minlength: 17

});

$.validator.addClassRules("frameNonoHN", {
	excludeStr: "Q"
});


/* 发动机号 */
$.validator.addClassRules("engineNo", {
	required: true,
	engineNoFormat: true,
	excludeStr: "Q,I,O"
});

/* 发动机号 */
$.validator.addClassRules("engineNoHN", {
	required: true,
	engineNoFormat: true,
	excludeStr: "I,O"
});

/* 特殊符号“*”排除 */
$.validator.addClassRules("excludeStar", {
	excludeStarNell: "\*"
});

/* 特殊符号排除 */
$.validator.addClassRules("excludeSpecialSign", {
	isEngineNo: true
});

/* 姓名 */
$.validator.addClassRules("validName", {
	required: true,
	isValidName: getTipTitleToParam
});

/* 车主姓名 */
$.validator.addClassRules("carOwnerName", {
	isCarOwnerName: true
});

/** 值列表 */
$.validator.addClassRules("ValLimit", {
	isInList: function(el) {
		var valsStr = $(el).attr("inList");
		var valArr = (valsStr == '' && typeof valsStr == 'undefined') ? new Array() : valsStr.split(',');
		return valArr;
	}
});

/** 用户手机号校验 */
$.validator.addClassRules("UserPhone", {
	uniqueUserPhone: true,
	required: true,
	mobilePhone: true
});

/** 注册电话 **/
$.validator.addClassRules("regPhone", {
	combimePhone: getTipTitleToParam,
	required: true
});

$.validator.addClassRules("RecommendedPhone", {
	mobilePhone: true
});
/**
 * 手机号码
 */
$.validator.addClassRules("mobilePhone", {
	mobilePhone: true,
	required: true
});

/**
 * 短信验证码校验
 */
$.validator.addClassRules("SMSCaptcha", {
	mobilePhone: true
});

/**
 * 银行帐号
 */
$.validator.addClassRules("bankAccount", {
	required: true,
	bankAccount: true
});

//输入的字符串的最大长度
$.validator.addClassRules("maxLen", {
    maxlength: getMaxLenToParam
});
//输入的字符串的长度范围
$.validator.addClassRules("rangeLen", {
    rangelength: getRangeLenToParam
});
//上传文件的类型
$.validator.addClassRules("acceptFile", {
    accept: getAcceptToParam
});

//返回Element的"maxLen"属性
function getMaxLenToParam(element) {
	return getElementMaxLen(element);
}
function getElementMaxLen(element){
	return $(element).attr("maxLen");
}
//返回Element的"minLen"属性
function getMinLenToParam(element) {
    return getElementMinLen(element);
}
function getElementMinLen(element){
    return $(element).attr("minLen");
}
//返回Element的"rangeLen"属性
function getRangeLenToParam(element) {
    return getElementRangeLen(element);
}
function getElementRangeLen(element){
     var rangeLen = $(element).attr("rangeLen").split(",");
     var minLen = rangeLen[0];
     var maxLen = rangeLen[1];
     return [minLen, maxLen];
}
//返回Element的"accept"属性
function getAcceptToParam(element) {
    return getElementAccept(element);
}
function getElementAccept(element){
    return $(element).attr("accept");
}
// 返回Element的"tipTitle"属性
function getTipTitleToParam(element) {
    return getElememtTipTitle(element);
}
function getElememtTipTitle(element) {
    return $(element).attr("tip-title");
}
/* jQuery Validation框架的自定义类规则 END */