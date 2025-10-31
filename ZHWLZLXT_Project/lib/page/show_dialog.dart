import 'package:flutter/material.dart';

Future<String?> promptText(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  bool isValid = false;

  String? _validator(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return '不能为空';
    if (s.length < 3) return '至少 3 个字符';
    // 需要特定格式时改这里，例如只允字母数字：
    final ok = RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(s);
    if (!ok) return '仅允许字母/数字/下划线';
    return null;
  }

  return showDialog<String>(
    context: context,
    barrierDismissible: false, // 点空白不关闭
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          void onChanged(String _) {
            // 实时校验以控制按钮可用态（不弹红字）
            isValid = _validator(controller.text) == null;
            setState(() {});
          }

          return AlertDialog(
            title: const Text('123456'),
            content: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: '至少 3 个字符',
                ),
                autofocus: true,
                textInputAction: TextInputAction.done,
                onChanged: onChanged,
                validator: _validator,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(null),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: isValid
                    ? () {
                  // 点击时再跑一次严谨校验
                  final ok = formKey.currentState?.validate() ?? false;
                  if (ok) {
                    Navigator.of(ctx).pop(controller.text.trim());
                  }
                }
                    : null, // 无效时禁用
                child: const Text('确定'),
              ),
            ],
          );
        },
      );
    },
  );
}
