import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/SignUpController.dart';

class ProfileImagePicker extends StatelessWidget {
  ProfileImagePicker({super.key,});
  final SignUpController controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.pickAvatarImage,
      child: Obx(() {
        return Container(
          height: 115,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
                26),
            border: Border.all(
                color: Colors.white.withOpacity(
                    0.2),
                style: BorderStyle.solid),
            image: controller.avatarImage.value !=
                null
                ? DecorationImage(
              image: FileImage(
                  controller.avatarImage.value!),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: controller.avatarImage.value ==
              null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                  Icons.person_add,
                  color: Color(0xFF712BB7),
                  size: 40),
              Text(
                "Upload Profile Photo",
                style: TextStyle(
                    color: Color(0xFF712BB7).withOpacity(0.6),
                    fontSize: 12),
              ),
            ],
          )
              : Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF8A1AD5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit,
                  size: 16, color: Colors.white),
            ),
          ),
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
