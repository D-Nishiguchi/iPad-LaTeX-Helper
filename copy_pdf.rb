# Require FileUtils module for file operations
require 'fileutils'

# Get today's date in yyyy-mm-dd format
today = Time.now.strftime("%Y-%m-%d")

# Define the PDF_Review directory path
PDF_Review_dir = File.expand_path("~/Library/Mobile Documents/com~apple~CloudDocs/PDF_Review/")

# Initialize the variable to store the newest PDF file path
pdf_file = nil

# Check if the 'out' directory exists
if File.exist?("out")
  # Get the newest PDF file in the 'out' directory
  pdf_file = Dir.glob("out/*.pdf").max_by { |f| File.mtime(f) }
# Check if there are any PDF files in the current directory
elsif Dir.glob("*.pdf").any?
  # Get the newest PDF file in the current directory
  pdf_file = Dir.glob("*.pdf").max_by { |f| File.mtime(f) }
else
  # If no PDF files are found, print a message and exit
  puts "No PDF files found."
  exit
end

# Create the PDF_Review directory if it doesn't exist
FileUtils.mkdir_p(PDF_Review_dir) unless Dir.exist?(PDF_Review_dir)

# Try to copy and rename the PDF file
begin
  FileUtils.cp(pdf_file, File.join(PDF_Review_dir, "#{today}.pdf"), preserve: true)
  puts "PDF file copied and renamed to '#{today}.pdf' in the 'PDF_Review' directory."
rescue StandardError => e
  puts "Failed to copy and rename the PDF file."
  puts "Error: #{e.message}"
end
