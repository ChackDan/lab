#Create an additional resource called upload_sonic_media to upload the files listed in the variable called media to this bucket.
#Use the following specifications:

#Use the for_each meta-argument to upload all the elements of the media variable.
#bucket: Use reference expression to the bucket sonic-media.
#source: Each element in the variable called media.
#key: Should be the name of the files being uploaded (minus the /media/). For an example, eggman.jpg, shadow.jpg e.t.c.


resource "aws_iam_user" "cloud" {
     name = split(":",var.cloud_users)[count.index]
     count = length(split(":",var.cloud_users))
  
}
resource "aws_s3_bucket" "sonic_media" {
     bucket = var.bucket
  
}
resource "aws_s3_object" "upload_sonic_media" {
  for_each = toset(var.media)

  bucket = aws_s3_bucket.sonic_media.bucket
  source = each.value
  key    = basename(each.value)
}
