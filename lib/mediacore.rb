require 'find'
require 'rexml/document'
require 'digest/sha1'

class MediaCore
  attr_accessor :directory, :files

  def initialize
    @directory = nil
  end

  def load_xml_data
    # load file hash data from file for fast access
    # might need to load index-*.xml to catch the file copy case
  end
end

class FileInfo
  attr_accessor :name, :size, :path, :series_name, :season_no, :episode_no

  def initialize(n=nil, s=0, p=nil)
    @name = n
    @size = s
    @path = p
  end
end


def get_mediacore_dir()
    directory = Dir.getwd
    while 1
        possible_directory = "#{directory}/.mediacore"
        return possible_directory if File.directory? possible_directory
        if directory == '/'
            puts "Unable to find MediaCore directory under #{Dir.getwd}"
            exit
        end
        directory = File.dirname(directory)
    end
end

def mediacore_init()
    Dir.mkdir('.mediacore')
end

def mediacore_status()
    mediacore_dir = get_mediacore_dir()
    puts "MediaCore directory is #{mediacore_dir}"
end

def mediacore_import()
    puts "MediaCore importing hashes"
    mediacore_dir = get_mediacore_dir()
    
    mediacore_hash_xml_filename = "#{mediacore_dir}/file_hashes.xml"
    xml_doc = REXML::Document.new
    xml_doc << REXML::XMLDecl.new
    root_node = xml_doc.add_element('files')
    Find.find('.') do |path|
        if FileTest.directory?(path)
             next if path == "."
             Find.prune if File.basename(path) =~ /^\./
        else
            node = root_node.add_element('file')
            node.attributes['path'] = File.dirname(path)
            node.attributes['size'] = File.size(path).to_s
            node.attributes['sha1'] = Digest::SHA1.file(path).hexdigest
            node.attributes['name'] = File.basename(path)
        end
    end
    file = File.new(mediacore_hash_xml_filename, "w+")
    xml_doc.write(file, 0)
end

def mediacore_check()
   mediacore_dir = get_mediacore_dir()

   mediacore_hash_xml_filename = "#{mediacore_dir}/file_hashes.xml"
   puts "#{mediacore_hash_xml_filename} loading.."
   file = File.new mediacore_hash_xml_filename
   xml_doc = REXML::Document.new file
   file_count = 0
   xml_doc.elements.each("/files/file") { |e| file_count = file_count + 1 }
   puts "check: #{file_count}"

end

def mediacore_fill_in_series_info(series, partial_info)
  if partial_info.name =~ /S(\d?\d)E(\d?\d)/
    partial_info.series_name = series.name
    partial_info.season_no = $1.to_i
    partial_info.episode_no = $2.to_i
    return
  end

  if partial_info.name =~ /(\d?\d)x(\d?\d)/
    partial_info.series_name = series.name
    partial_info.season_no = $1.to_i
    partial_info.episode_no = $2.to_i
    return
  end
end
