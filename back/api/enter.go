package api

import "backend/service"

var (
	userService            = &service.UserService{}
	roleService            = &service.RoleService{}
	permissionService      = &service.PermissionService{}
	projectService         = &service.ProjectService{}
	projectStageService    = &service.ProjectStageService{}
	projectDelayService    = &service.ProjectDelayService{}
	projectDownService     = &service.ProjectDownService{}
	projectDocumentService = &service.ProjectDocumentService{}
	announceService        = &service.AnnounceService{}
	noteService            = &service.NoteService{}
)
