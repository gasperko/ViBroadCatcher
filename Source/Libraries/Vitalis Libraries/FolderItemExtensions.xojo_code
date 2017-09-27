#tag Module
Protected Module FolderItemExtensions
	#tag Method, Flags = &h0
		Function CopyFolderTo(Extends source as FolderItem, destination as FolderItem) As Boolean
		  Return CopyFolderTo( source, destination )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CopyFolderTo(source as FolderItem, destination as FolderItem) As Boolean
		  // From http://docs.xojo.com/index.php/FolderItem
		  
		  // The following example method copies a source folderitem to a new destination using CopyFileTo.
		  // Returns True if all files in the folder were successfully copied, returns False otherwise.
		  
		  // Likely merges folders if an folder with the same name already exists at the destination.
		  
		  Dim newFolder As FolderItem
		  If source.Directory then //it's a folder
		    newFolder = destination.Child(source.Name)
		    newFolder.CreateAsFolder
		    if not newFolder.Exists or not newFolder.Directory Then
		      // folder was not created - abort
		      Return False
		    End If
		    For i As Integer = 1 To source.Count //go through each item
		      Dim sourceItem as FolderItem = source.TrueItem(i)
		      If sourceItem = nil Then
		        // inaccessible
		        Return False
		      End If
		      If not CopyFolderTo(sourceItem, newFolder) Then
		        //copy operation failed
		        Return False
		      End If
		    Next
		  Else //it's not a folder
		    source.CopyFileTo destination
		    If source.LastErrorCode <> 0 Then
		      Return False
		    End If
		  End if
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteFolder(Extends theFolder as FolderItem, continueIfErrors as Boolean = false) As Integer
		  Return DeleteFolder( theFolder, continueIfErrors )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteFolder(theFolder as FolderItem, continueIfErrors as Boolean = false) As Integer
		  // From: http://docs.xojo.com/index.php/FolderItem.Delete
		  
		  // Returns an error code if it fails, or zero if the folder was deleted successfully
		  
		  dim returnCode, lastErr, itemCount as integer
		  dim files(), dirs() as FolderItem
		  
		  if theFolder = nil or not theFolder.Exists() then
		    return 0
		  end if
		  
		  // Collect the folder‘s contents first.
		  // This is faster than collecting them in reverse order and deleting them right away!
		  itemCount = theFolder.Count
		  for i as integer = 1 to itemCount
		    dim f as FolderItem
		    f = theFolder.TrueItem( i )
		    if f <> nil then
		      if f.Directory then
		        dirs.Append f
		      else
		        files.Append f
		      end if
		    end if
		  next
		  
		  // Now delete the files
		  for each f as FolderItem in files
		    f.Delete
		    lastErr = f.LastErrorCode   // Check if an error occurred
		    if lastErr <> 0 then
		      if continueIfErrors then
		        if returnCode = 0 then returnCode = lastErr
		      else
		        // Return the error code if any. This will cancel the deletion.
		        return lastErr
		      end if
		    end if
		  next
		  
		  redim files(-1) // free the memory used by the files array before we enter recursion
		  
		  // Now delete the directories
		  for each f as FolderItem in dirs
		    lastErr = DeleteFolder( f, continueIfErrors )
		    if lastErr <> 0 then
		      if continueIfErrors then
		        if returnCode = 0 then returnCode = lastErr
		      else
		        // Return the error code if any. This will cancel the deletion.
		        return lastErr
		      end if
		    end if
		  next
		  
		  if returnCode = 0 then
		    // We‘re done without error, so the folder should be empty and we can delete it.
		    theFolder.Delete
		    returnCode = theFolder.LastErrorCode
		  end if
		  
		  return returnCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Files(Extends TheFolder as FolderItem) As FolderItem()
		  dim Contents() as FolderItem
		  if TheFolder <> Nil and TheFolder.Exists and TheFolder.Directory then
		    
		    for i as Integer = 1 to TheFolder.Count
		      dim item as FolderItem = TheFolder.Item(i)
		      
		      if item <> Nil and item.Exists and item.Visible and NOT item.Directory then
		        Contents.Append item
		      else
		        Continue
		      end if
		      
		    next
		    
		  end if
		  
		  Return Contents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Folders(Extends TheFolder as FolderItem) As FolderItem()
		  dim Contents() as FolderItem
		  if TheFolder <> Nil and TheFolder.Exists and TheFolder.Directory then
		    
		    for i as Integer = 1 to TheFolder.Count
		      dim item as FolderItem = TheFolder.Item(i)
		      
		      if item <> Nil and item.Exists and item.Visible and item.Directory then
		        Contents.Append item
		      else
		        Continue
		      end if
		      
		    next
		    
		  end if
		  
		  Return Contents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImageFiles(Extends TheFolder as FolderItem) As FolderItem()
		  dim Contents() as FolderItem
		  if TheFolder <> Nil and TheFolder.Exists and TheFolder.Directory then
		    
		    for i as Integer = 1 to TheFolder.Count
		      dim item as FolderItem = TheFolder.Item(i)
		      
		      if item <> Nil and item.Exists and item.Visible and FileTypeImages.All.Contains( item.Type ) then
		        Contents.Append item
		      else
		        Continue
		      end if
		      
		    next
		    
		  end if
		  
		  Return Contents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Items(Extends TheFolder as FolderItem) As FolderItem()
		  dim Contents() as FolderItem
		  if TheFolder <> Nil and TheFolder.Exists and TheFolder.Directory then
		    
		    for i as Integer = 1 to TheFolder.Count
		      dim item as FolderItem = TheFolder.Item(i)
		      
		      if item <> Nil and item.Exists and item.Visible then
		        Contents.Append item
		      else
		        Continue
		      end if
		      
		    next
		    
		  end if
		  
		  Return Contents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LabelIndex(extends ForItem as FolderItem) As Integer
		  dim ae as AppleEvent
		  
		  dim file as AppleEventObjectSpecifier
		  dim myPath as String
		  
		  
		  if ForItem = Nil then
		    Return 0
		  end if
		  ae = New AppleEvent( "core", "getd", "MACS" ) // The "Get" apple event
		  myPath = FileManager.NativePath( ForItem )
		  
		  file = GetNamedObjectDescriptor( "alis", Nil, myPath ) //"Converts" a file to an AppleEvent object
		  
		  ae.ObjectSpecifierParam( "----" ) = GetPropertyObjectDescriptor( file, "labi" ) //This references the label index property of the "file" object.
		  
		  if NOT ae.Send then
		  end if
		  
		  Return ae.ReplyInteger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LabelIndex(extends ForItem as Folderitem, assigns LabelIndex as Integer)
		  // 0 = Clear
		  // 1 = Orange
		  // 2 = Red
		  // 3 = Yellow
		  // 4 = Blue
		  // 5 = Purple
		  // 6 = Green
		  // 7 = Gray
		  
		  dim ae as AppleEvent
		  'dim f as FolderItem
		  dim file as AppleEventObjectSpecifier
		  dim myPath as String
		  'dim o as AppleEventObjectSpecifier
		  
		  if ForItem = Nil then
		    Return
		  end if
		  
		  ae = New AppleEvent( "core", "setd", "MACS" ) //The "Set" apple event
		  myPath = FileManager.NativePath( ForItem )
		  
		  file = GetNamedObjectDescriptor( "alis", Nil, myPath ) //"Converts" a file to an AppleEvent object
		  
		  ae.ObjectSpecifierParam( "----" ) = GetPropertyObjectDescriptor( file, "labi" ) //This references the label index property of the "file" object.
		  
		  ae.IntegerParam("data") = LabelIndex //The label index
		  if Not ae.Send then
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RevealInFileBrowser(Extends f as FolderItem)
		  
		  if f <> Nil and f.Exists then
		    #if TargetMacOS then
		      f.RevealInFinder
		    #else
		      f.Launch
		    #endif
		  end if
		End Sub
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
