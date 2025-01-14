extends Control

var upper_slider: HSlider
var lower_slider: HSlider
var upper_degree_label: Label
var lower_degree_label: Label
var reset_button: Button

var skel: Skeleton3D
var upper_id: int
var lower_id: int
var upper_slider_value: float = 50.0
var lower_slider_value: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upper_slider = $UpperSlider
	upper_degree_label = $UpperDegreeLabel
	lower_slider = $LowerSlider
	lower_degree_label = $LowerDegreeLabel
	reset_button = $ResetButton
	skel = get_node("Model/Skeleton3D")
	upper_id = skel.find_bone("mixamorig1_Spine2")
	lower_id = skel.find_bone("mixamorig1_Spine")
	
	upper_slider.value = upper_slider_value
	lower_slider.value = lower_slider_value
	
	upper_slider.value_changed.connect(_on_upper_slider_changed)
	lower_slider.value_changed.connect(_on_lower_slider_changed)
	reset_button.pressed.connect(_on_reset_button_click)

func _set_upper_slider_value(value: float) -> void:
	upper_slider_value = value
	upper_slider.value = value
	var degree = ((value - 50) / 100) * 180
	upper_degree_label.text = String.num(degree, 2) + "°"

func _on_reset_button_click() -> void:
	print("dfg")

func _on_upper_slider_changed(value: float) -> void:
	var degree = ((value - 50) / 100) * 180
	upper_degree_label.text = String.num(degree, 2) + "°"
	
	var diff: float = value - upper_slider_value
	upper_slider_value = value
	
	var upper: Transform3D = skel.get_bone_pose(upper_id)
	upper = upper.rotated(Vector3(0, 0, 1), diff/100)
	skel.set_bone_pose(upper_id, upper)

func _on_lower_slider_changed(value: float) -> void:
	var degree = ((value - 50) / 100) * 180
	lower_degree_label.text = String.num(degree, 2) + "°"
	
	var diff: float = value - lower_slider_value
	lower_slider_value = value
	
	var lower: Transform3D = skel.get_bone_pose(lower_id)
	lower = lower.rotated(Vector3(0, 0, 1), diff/100)
	skel.set_bone_pose(lower_id, lower)
