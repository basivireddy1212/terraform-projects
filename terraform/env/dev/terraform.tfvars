environment = "dev"
project_id = "devops-june"
region = "us-west1"
zones = ["us-west1-a","us-west1-b", "us-west1-c"]

region_disks = {}
organization_labels = {
    purpose = "test1"
}

buckets = {
     test1 = {
         name = "re-test11232333"
         location = "US"
     }
}

bucket_iam_member = {
    "roles/storage.objectViewer" = {
        bucket_name = "testre-test11232333"
        role = "roles/storage.objectViewer"
        member = "user:test@gmail.com"
        delete = false
    },
    "roles/storage.objectViewer" = {
        bucket_name = "testre-test11232333"
        role = "roles/storage.objectViewer"
        member = "user:test1212@gmail.com"
        delete = false
    }
}

service_accounts = {
    # keys should be unique
    "a" = {
        account_id   = "test-sa-1"
        display_name = "test-sa-1"
        description  = "This is test service account 1"
        delete = false
        project_id = "devops-june"
    },
    "a" = {
        account_id   = "test-sa-2"
        display_name = "test-sa-2"
        description  = "This is test service account 1"
        delete = false
        project_id = "devops-june"
    }
}

keyrings = {
#    "test1" = {
#        kms_key_ring_name = "test-kms-key-ring-2"
#        location = "us-west1"
#        project_id = "devops-june"
#        delete = false
#    },
#    "test2" = {
#        kms_key_ring_name = "test-kms-key-ring-3"
#        location = "us-west1"
#        project_id = "devops-june"
#        delete = false
#    }
}


keynames = {
    test1 = {
        kms_key_name = "test-kms-key-1"
        key_ring = "projects/devops-june/locations/us-west1/keyRings/test-kms-key-ring-1"
        delete = false
    },
    test2 = {
        kms_key_name = "test-kms-key-2"
        key_ring = "projects/devops-june/locations/us-west1/keyRings/test-kms-key-ring-2"
        delete = false
    },
    test2 = {
        kms_key_name = "test-kms-key-3"
        key_ring = "projects/devops-june/locations/us-west1/keyRings/test-kms-key-ring-2"
        delete = false
    }
}

