#tag Module
Protected Module NotificationCenter
	#tag Method, Flags = &h1
		Protected Sub Message(TheMessage as String)
		  #if TargetMacOS then
		    if NSUserNotification.Available then // Notification Center
		      Notify( AppSettings.kAppName, "", TheMessage )
		    else
		      log TheMessage
		    end if
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Notify(Title as String = "", Subtitle as String = "", Message as String = "", ActionButton as String = "", OtherButton as String = "")
		  #if TargetMacOS then
		    Dim n as New NSUserNotification
		    
		    if Title <> "" then
		      n.Title = Title
		    end if
		    
		    if Subtitle <> "" then
		      n.Subtitle = Subtitle
		    end if
		    
		    if Message <> "" then
		      n.InformativeText = Message
		    end if
		    
		    if ActionButton <> "" then
		      n.ActionButtonTitle = ActionButton
		      n.HasActionButton = True
		    end if
		    
		    if OtherButton <> "" then
		      n.otherButtonTitle = OtherButton
		    end if
		    
		    m.DeliverNotification( n )
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Register()
		  
		  #if TargetMacOS then
		    // Create new instance of notification center 
		    m = New MyNotificationCenter
		  #endif
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private GrowlBinary As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private m As NSUserNotificationCenter
	#tag EndProperty


	#tag Enum, Name = Priority, Flags = &h0
		VeryLow = -2
		  Moderate = -1
		  Normal = 0
		  High = 1
		Emergency = 2
	#tag EndEnum


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
