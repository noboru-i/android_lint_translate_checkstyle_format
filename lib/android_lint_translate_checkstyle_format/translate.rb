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
      issues = xml['issues']['issue'].is_a?(Array) ? xml['issues']['issue'] : [xml['issues']['issue']]
      issues.each do |issue|
        locations = issue['location'].is_a?(Array) ? issue['location'] : [issue['location']]
        locations.each do |location|
          file = checkstyle.add_element("file", {
            'name' => location['@file']
            })
          file.add_element("error", {
            'line' => location['@line'],
            'severity' => issue['@severity'],
            'message' => "[#{issue['@id']}] #{issue['@message']}\n #{issue['@explanation']}"
            })
        end
      end

      doc
    end
  end
end
