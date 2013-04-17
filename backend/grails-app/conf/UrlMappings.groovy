class UrlMappings {

	static mappings = {

        "/sample"(controller: "sample", action: "sampleMongo")

		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(view:"/index")
		"500"(view:'/error')
	}
}
