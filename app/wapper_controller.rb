class WapperController < UIViewController

  def loadView
    self.view = UIImageView.alloc.init
    view.contentMode = UIViewContentModeScaleAspectFill
    view.userInteractionEnabled = true
    view.backgroundColor = UIColor.whiteColor
    view.alpha = 0.1
    view.image = UIImage.imageNamed("ballmer.jpg")
    pick_image_with_source(UIImagePickerControllerSourceTypeCamera)
  end

  def viewDidLoad
   # NSLog "i loaded"
    UIAccelerometer.sharedAccelerometer.updateInterval = 1.0
    UIAccelerometer.sharedAccelerometer.delegate = self
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(true, animated:true)
    navigationController.toolbarHidden = true

    self.becomeFirstResponder
    super
  end

  def canBecomeFirstResponder
    true
  end

  def motionEnded(motion, withEvent:event)
    if event.subtype == UIEventSubtypeMotionShake
      view.alpha = view.alpha + 0.1
    end
  end

  def pick_image_with_source(source_type)
    NSLog 'over here'
    # Create and show the image picker.
    imagePicker = UIImagePickerController.alloc.init
    imagePicker.sourceType =  source_type
    imagePicker.mediaTypes = [KUTTypeImage]
    imagePicker.delegate = self
    imagePicker.allowsImageEditing = false
    NSLog 'and here'
    presentModalViewController(imagePicker, animated:true)
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo:info)
    mediaType = info[UIImagePickerControllerMediaType]
    if mediaType == KUTTypeImage
      editedImage = info[UIImagePickerControllerEditedImage]
      originalImage = info[UIImagePickerControllerOriginalImage]
      view.image = editedImage || originalImage
    end
    dismissModalViewControllerAnimated(true)
  end

end
