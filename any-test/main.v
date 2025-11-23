// related to https://zenn.dev/link/comments/37315988830f87

import x.json2

type Any = json2.Any

fn main(){
	mut dict := map[string]Any{}
	dict["hello"] = Any("hello")
	dict["number"] = Any(3.0)

	println(dict["hello"].str())
	println(dict["number"].f32())
}