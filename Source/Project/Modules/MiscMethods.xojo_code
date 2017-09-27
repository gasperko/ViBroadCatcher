#tag Module
Protected Module MiscMethods
	#tag Method, Flags = &h0
		Function Articulator(ItemName as string) As String
		  // English
		  if ItemName.StartsWith( "The " ) then
		    ItemName = ItemName.Right( ItemName.Len - 4 ) + ", The"
		  elseif ItemName.StartsWith( "A " ) then
		    ItemName = ItemName.Right( ItemName.Len - 2 ) + ", A"
		  elseif ItemName.StartsWith( "An " ) then
		    ItemName = ItemName.Right( ItemName.Len - 3 ) + ", An"
		    
		    // Nederlands
		  elseif ItemName.StartsWith( "Het " ) then
		    ItemName = ItemName.Right( ItemName.Len - 4 ) + ", Het"
		  elseif ItemName.StartsWith( "De " ) then
		    ItemName = ItemName.Right( ItemName.len - 3 ) + ", De"
		  elseif ItemName.StartsWith( "Een " ) then
		    ItemName = ItemName.Right( ItemName.Len - 4 ) + ", Een"
		  end if
		  
		  return ItemName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CleanName(name as String) As String
		  dim newName as string = Trim( name )
		  
		  newName = newName.ReplaceAll( ":", " - " )
		  
		  // Remove double spaces
		  if newName.Contains( "  " ) then
		    while newName.Contains( "  " )
		      newName = newName.ReplaceAll( "  ", " " )
		    wend
		  end if
		  
		  // Remove dots from start
		  'if newName.Left(1) = "." then
		  'newName = " " + newName
		  'end if
		  
		  // Remove dots from start
		  if newName.StartsWith( "." ) then
		    while newName.StartsWith( "." )
		      newName = newName.Right( newName.Len - 1 )
		    wend
		  end if
		  
		  return newName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CountryCodeToFlagEmoji(Code as String) As String
		  Select case Code
		  case "au"
		    return "🇦🇺"
		  case "ar"
		    return "🇸🇦"
		  case "be"
		    return "🇧🇪"
		  case "br"
		    return "🇧🇷"
		  case "ca"
		    return "🇨🇦"
		  case "cs"
		    return "🇨🇿"
		  case "da"
		    return "🇩🇰"
		  case "de"
		    return "🇩🇪"
		  case "es"
		    return "🇪🇸"
		  case "fi"
		    return "🇫🇮"
		  case "fr"
		    return "🇫🇷"
		  case "gb", "uk", "en"
		    return "🇬🇧"
		  case "gr"
		    return "🇬🇷"
		  case "hr"
		    return "🇭🇷"
		  case "hu"
		    return "🇭🇺"
		  case "ie"
		    return "🇮🇪"
		  case "il"
		    return "🇮🇱"
		  case "it"
		    return "🇮🇹"
		  case "ja"
		    return "🇯🇵"
		  case "ko"
		    return "🇰🇷"
		  case "mx"
		    return "🇲🇽"
		  case "nl"
		    return "🇳🇱"
		  case "no"
		    return "🇳🇴"
		  case "pl"
		    return "🇵🇱"
		  case "pt"
		    return "🇵🇹"
		  case "ro"
		    return "🇷🇴"
		  case "ru"
		    return "🇷🇺"
		  case "se"
		    return "🇸🇪"
		  case "sl"
		    return "🇸🇱"
		  case "sv"
		    return "🇸🇪"
		  case "tr"
		    return "🇹🇷"
		  case "us"
		    return "🇺🇸"
		  case "vn"
		    Return "🇻🇳"
		  case "zh"
		    return "🇨🇳"
		    
		  else
		    return ""
		  end Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CountryToCode(Name as String) As String
		  
		  Select case name
		    
		  case "Arabic", "عربي"
		    return "ar"
		  case "Chinese", "中文"
		    return "zh"
		  case "English"
		    return "en"
		  case "French", "Français"
		    return "fr"
		  case "Hungarian", "Magyar"
		    return "hu"
		  case "Italian", "Italiano"
		    return "it"
		  case "Polish", "Polski"
		    return "pl"
		  case "Portuguese", "Português"
		    return "pt"
		  case "Romanian", "Română"
		    return "ro"
		  case "Russian", "русский"
		    return "ru"
		  case "Spanish", "Español"
		    return "es"
		  case "Vietnamese", "Tiếng Việt"
		    return "vn"
		  case "Japanese", "日本語"
		    return "ja"
		  case "Korean", "한국어"
		    return "ko"
		  case "Netherlands", "Nederland"
		    Return "nl"
		    
		  else
		    return "en"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLFileName(URL as String) As String
		  if URL <> "" then
		    dim FileName as string
		    if URL.EndsWith( "/" ) then
		      FileName = URL.NthField( "/", URL.CountFields( "/" ) -1 )
		    else
		      FileName = URL.NthField( "/", URL.CountFields( "/" ) )
		    end if
		    return FileName
		    
		  else
		    return ""
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLHost(URL as String, WholeHost as Boolean = False) As String
		  if URL <> "" then
		    dim originalURL as string = URL
		    URL = URL.Replace( "http://", "" )
		    URL = URL.Replace( "https://", "" )
		    URL = URL.Replace( "www.", "" )
		    
		    dim host as string = URL.NthField( "/", 1 )
		    if WholeHost then
		      host = originalURL.NthField( host, 1 ) + host
		      return host
		    else
		      return host
		    end if
		    
		  else
		    return ""
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLtoName(url as String) As String
		  dim urlName as string = url.NthField( "/", url.CountFields("/") )
		  if urlName = "" then
		    urlName = url.NthField( "/", url.CountFields("/")-1 )
		  end if
		  
		  urlName = urlName.Replace( ".html", "" )
		  urlName = urlName.ReplaceAll( "_", " " )
		  urlName = urlName.ReplaceAll( "-", " ")
		  urlName = urlName.ReplaceAll( "+", " ")
		  urlName = DecodeURLComponent( urlName )
		  urlName = urlName.Titlecase
		  
		  Return urlName
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
