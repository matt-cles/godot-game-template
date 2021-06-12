extends Object
class_name SymanticVersion

# A simple class that allows us to compare the settings versions simply
var major
var minor
var fix

func _init(_major, _minor=0, _fix=0):
	self.major = _major
	self.minor = _minor
	self.fix = _fix

func less_than(other:SymanticVersion) -> bool:
	if major < other.major:
		return true
	if major > other.major:
		return false
	if minor < other.minor:
		return true
	if minor > other.minor:
		return false
	if fix < other.fix:
		return true
	return false

func greater_than(other:SymanticVersion) -> bool:
	if major > other.major:
		return true
	if major < other.major:
		return false
	if minor > other.minor:
		return true
	if minor < other.minor:
		return false
	if fix > other.fix:
		return true
	return false

func equal_to(other:SymanticVersion) -> bool:
	return major == other.major and minor == other.minor and fix == other.fix
