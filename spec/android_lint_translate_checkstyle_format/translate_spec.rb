require 'spec_helper'

describe AndroidLintTranslateCheckstyleFormat::Translate do
  include AndroidLintTranslateCheckstyleFormat::Translate
  context 'one issue' do
    xml = {
      'issues' => {
        'issue' => {
          '@severity' => 'Warning',
          'location' => {
            '@file' => 'test.xml',
            '@line' => 99
          }
        }
      }
    }
    it 'no error' do
      expect(trans(xml)).not_to be_nil
    end
  end

  context 'two issues' do
    xml = {
      'issues' => {
        'issue' => [
          {
            '@severity' => 'Warning',
            'location' => {
              '@file' => 'test.xml',
              '@line' => 99
            }
          },
          {
            '@severity' => 'Warning',
            'location' => {
              '@file' => 'test.xml',
              '@line' => 99
            }
          }
        ]
      }
    }
    it 'no error' do
      expect(trans(xml)).not_to be_nil
    end
  end
end
