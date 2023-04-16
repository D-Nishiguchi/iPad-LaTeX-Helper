# Require FileUtils module for file operations
require 'fileutils'

# Get today's date in yyyy-mm-dd format
today = Time.now.strftime("%Y-%m-%d")

# Define the buffer directory path
buffer_dir = File.expand_path("~/Library/Mobile Documents/com~apple~CloudDocs/buffer/")

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

# Create the buffer directory if it doesn't exist
FileUtils.mkdir_p(buffer_dir) unless Dir.exist?(buffer_dir)

# Try to copy and rename the PDF file
begin
  FileUtils.cp(pdf_file, File.join(buffer_dir, "#{today}.pdf"), preserve: true)
  puts "PDF file copied and renamed to '#{today}.pdf' in the 'buffer' directory."
rescue StandardError => e
  puts "Failed to copy and rename the PDF file."
  puts "Error: #{e.message}"
end
