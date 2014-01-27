class email {
	class{'email::packages':}
	->
	class{'email::config':}		
	->
	class{'email::commands':}

}