module AndroidLintTranslateCheckstyleFormat
  class Script
    extend ::AndroidLintTranslateCheckstyleFormat::Translate
    def self.translate(xml_text)
      trans(parse(xml_text)).to_s
    end
  end
end
