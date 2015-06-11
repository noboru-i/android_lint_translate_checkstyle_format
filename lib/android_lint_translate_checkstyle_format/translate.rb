require 'nori'

module AndroidLintTranslateCheckstyleFormat
  module Translate
    def parse(xml)
      Nori
        .new(parser: :rexml)
        .parse(xml)
    end

    def trans(xml)
      require 'rexml/document'
      doc = REXML::Document.new
      doc << REXML::XMLDecl.new('1.0', 'UTF-8')

      checkstyle = doc.add_element("checkstyle")
      xml['issues']['issue'].each do |issue|
        file = checkstyle.add_element("file", {
          'name' => issue['location']['@file']
          })
        file.add_element("error", {
          'line' => issue['location']['@line'],
          'severity' => issue['severity'],
          'message' => "[#{issue['@id']}] #{issue['@message']}\n #{issue['@explanation']}"
          })
      end

      doc
    end
  end
end
