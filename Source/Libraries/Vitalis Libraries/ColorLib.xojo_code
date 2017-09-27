#tag Module
Protected Module ColorLib
	#tag Method, Flags = &h0
		Function ChromaU(extends c as Color) As Integer
		  // Returns the "U" component of YUV
		  Return ( (c.red * -0.169) + (c.green * -0.332) + (c.blue * 0.500) ) + 128.0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChromaV(extends c as color) As Integer
		  // Returns the "V" component of YUV
		  Return ( (c.red * 0.500) + (c.green * -0.419) + (c.blue * -0.0813) ) + 128.0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChromaY(extends c as color) As Integer
		  // Returns the "Y" component of YUV, Luminance
		  Return ( (c.red * 0.299) + (c.green * 0.587) + (c.blue * 0.114) )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Gray(x as Integer) As Color
		  Return RGB(x, x, x)
		  
		  //    This is a function similar to RGB(), HSV() and CMY(), but only takes a single value
		  //    to create a Gray color.
		  //
		  //    This is more of a conveniance function, and may cost more CPU time than using
		  //    the regular RGB() function.  You should only use this function if you write a
		  //    single calculation that needs to be applied to all three parts of RGB, and don't store
		  //    the result in another local variable.
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HSL(Hue as Double, Saturation as Double, Lightness as Double, Alpha as Double = 100) As Color
		  dim Red, Green, Blue as Double
		  
		  Hue        = Hue / 360'º
		  Saturation = Saturation / 100'%
		  Lightness  = Lightness / 100'%
		  Alpha      = ( 100 - Alpha ) / 100'%
		  
		  if Saturation = 0 then
		    Red   = Lightness
		    Green = Lightness
		    Blue  = Lightness
		  else
		    dim q, p as Double
		    if Lightness < 0.5 then
		      q = ( Lightness * ( 1 + Saturation ) )
		    else
		      q = ( Lightness + Saturation - Lightness * Saturation )
		    end if
		    p = 2 * Lightness - q
		    
		    Red   = Hue2RGB( p, q, Hue + 1/3 )
		    Green = Hue2RGB( p, q, Hue )
		    Blue  = Hue2RGB( p, q, Hue - 1/3 )
		  end if
		  
		  Return RGB( Red * 255, Green * 255, Blue * 255, Alpha * 255 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hue2RGB(p as Double, q as Double, t as Double) As Double
		  If t < 0 Then t = t + 1
		  If t > 1 Then t = t - 1
		  If t < 1/6 Then Return ( p + ( q - p ) * 6 * t )
		  If t < 1/2 Then Return ( q )
		  If t < 2/3 Then Return ( p + ( q - p ) * (2/3 - t) * 6 )
		  Return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RGB2HSL(R as Double, G as Double, B as Double) As Double()
		  r = r / 255
		  g = g / 255
		  b = b / 255
		  
		  dim valMax as Double = Max( r, g, b )
		  dim valMin as Double = Min( r, g, b )
		  
		  dim h, s, l as Double = ( valMax + valMin ) / 2
		  
		  if valMax = valMin then
		    h = 0
		    s = 0
		  else
		    
		    dim d as Double = valMax - valMin
		    
		    if l > 0.5 then
		      s = d / ( 2 - valMax - valMin )
		    else
		      s = d / ( valMax + valMin )
		    end if
		    
		    select case( valMax )
		      
		    case r
		      h = (g -b) / d
		      if g < b then h = h + 6
		      
		    case g
		      h = (b - r) / d + 2
		      
		    case b
		      h = (r - g) / d + 4
		      
		    end select
		    h = h / 6
		    
		  end if
		  
		  Return Array( h * 360, s * 100, l * 100 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RGBa(Red as Double, Green as Double, Blue as Double, Alpha as Double = 100) As Color
		  // Works with percentiles rather then dehexified (0-255) values.
		  
		  Red   = ( Red / 100 ) * 255
		  Green = ( Green / 100 ) * 255
		  Blue  = ( Blue / 100 ) * 255
		  Alpha = 255 - ( ( Alpha / 100 ) * 255 )
		  
		  Return RGB( Red, Green, Blue, Alpha )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function YUV(Y as Integer, U as Integer, V as Integer) As Color
		  dim R, G, B As Integer
		  
		  R = Y + (1.4075 * (V - 128))
		  G = Y - (0.3455 * (U - 128) - (0.7169 * (V - 128)))
		  B = Y + (1.7790 * (U - 128))
		  
		  Return RGB(R, G, B)
		  
		  //    YUV is a colorspace most commonly used in video.
		  //
		  //    Y is the luminance (absolute white to absolute black), U is the blending between
		  //    blue and yellow, and V is the blending between red and cyan.  The human eye is
		  //    less sensitive to colour variations than to intensity variations. YUV allows the
		  //    encoding of luminance (Y) information at full bandwidth and chrominance (UV)
		  //    information at reduced bandwidth.  Another advantage is that YUV provides is
		  //    that the Luminance component provides a very good grayscale resprentation of
		  //    the color... with several functions in GraphicUtils dependant on this colorspace.
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