require 'xmlrpc/client'

class XMLRPC::XMLParser::AbstractStreamParser

  #A patch for the response method as rtorrent xmlrpc
  #call returns some integers as i8 instead of i4 expected
  #this results in int8 fields showing up with no data
  #as the parse method is not capable of handling such 
  #a tag.
  alias original_parseMethodResponse parseMethodResponse
  def parseMethodResponse(str)
    str.gsub!(/<((\/)*)i8>/, "<\\1i4>")
    original_parseMethodResponse(str)
  end
end

