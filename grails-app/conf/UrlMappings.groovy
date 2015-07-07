class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

		"/budget/$year/"(controller:'budget', action:'index')
		"/budget/$year/$month"(controller:'budget', action:'index')
		
        "/"(controller:"budget", action:'index')
        "500"(view:'/error')
	}
}
