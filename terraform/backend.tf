terraform {
  cloud {
    organization = "stephenoni67" #change this to your terraform cloud organization name
    
    workspaces {
      name = "stephenoni67" #change this to your terraform cloud workspace name
    }
  }
}