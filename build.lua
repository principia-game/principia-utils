
-- Where the Principia source tree is located
local PREFIX = "src"

-- Common build flags
local COMMON_FLAGS = "-D_NO_TMS -D__STDC_FORMAT_MACROS=1 -O2"

-- Include dirs
local INCLUDE_DIRS = {
	"-I"..PREFIX.."/src/src/",
	"-I"..PREFIX.."/src/"}

-- Build function
-- output: Name of util, will be the output
-- libs: Libraries to link against
-- src: List of util source files
-- ext: List of Principia source files
local function build(output, libs, src, ext)
	print("Building "..output.."...")

	local command = {
		"g++",
		COMMON_FLAGS,
		table.concat(INCLUDE_DIRS, " "),
	}

	for _, file in ipairs(src) do
		table.insert(command, output..'/'..file)
	end

	for _, file in ipairs(ext) do
		table.insert(command, PREFIX.."/src/src/"..file)
	end

	for _,lib in ipairs(libs) do
		table.insert(command, "-l"..lib)
	end

	table.insert(command, "-o bin/"..output)

	local code = os.execute(table.concat(command, ' '))

	if code == 0 then
		print("Successfully built "..output..".")
	else
		print("Failed to build "..output..", exiting...")
		os.exit(1)
	end
end

-- Build utils

os.execute("mkdir -p bin")

build('lvledit', {'z'}, {'main.cc'}, {'pkgman.cc', 'rand.c'})

build('progress-get', {'z'}, {'main.cc'}, {'progress.cc'})
