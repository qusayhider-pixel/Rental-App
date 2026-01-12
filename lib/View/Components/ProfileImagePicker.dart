import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/SignUpController.dart';

class ProfileImagePicker extends StatelessWidget {
  ProfileImagePicker({super.key, required this.radius});
  final SignUpController controller = Get.find<SignUpController>();
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.pickAvatarImage,
      child: Obx(() {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: const Color(0xcba474fe),
              backgroundImage: controller.avatarImage.value != null
                  ? FileImage(controller.avatarImage.value!)
                  : null,
              child: controller.avatarImage.value == null
                  ? const Icon(Icons.person, size: 50, color: Colors.white)
                  : null,
            ),
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xcba474fe),
              child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
            ),
          ],
        );
      }),
    );
  }
}






// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

//   class ProfileImagePicker extends StatefulWidget {
//   const ProfileImagePicker({super.key});

//   @override
//   State<ProfileImagePicker> createState() => ProfileImagePickerState();
// }

// class ProfileImagePickerState extends State<ProfileImagePicker> {
//   File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();
//   File? get selectedImage => null;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _pickImage,
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         children: [

//           CircleAvatar(
//             radius: 60,
//             backgroundColor: Color(0xcba474fe),
//             backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
//             child: _selectedImage == null ? const Icon(Icons.person, size: 50, color: Colors.white) : null,
//           ),

//           CircleAvatar(
//             radius: 18,
//             backgroundColor: Color(0xcba474fe),
//             child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }


//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
        
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }
// }
