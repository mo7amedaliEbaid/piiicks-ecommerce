import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/mobile_number_textfield.dart';
import 'package:piiicks/presentation/widgets/textfield_toptext.dart';

import '../../application/delivery_info_action_cubit/delivery_info_action_cubit.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../application/notifications_cubit/notifications_cubit.dart';
import '../../data/models/delivery/delivery_info_model.dart';
import '../../domain/entities/delivery/delivery_info.dart';
import '../widgets/custom_textfield.dart';

class AddAddressScreen extends StatefulWidget {
  final DeliveryInfo? deliveryInfo;

  const AddAddressScreen({
    super.key,
    this.deliveryInfo,
  });

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String? id;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _addressLineOne = TextEditingController();
  final TextEditingController _addressLineTwo = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.deliveryInfo != null) {
      id = widget.deliveryInfo!.id;
      _firstName.text = widget.deliveryInfo!.firstName;
      _lastName.text = widget.deliveryInfo!.lastName;
      _addressLineOne.text = widget.deliveryInfo!.addressLineOne;
      _addressLineTwo.text = widget.deliveryInfo!.addressLineTwo;
      _city.text = widget.deliveryInfo!.city;
      _zipCode.text = widget.deliveryInfo!.zipCode;
      _contactNumber.text = widget.deliveryInfo!.contactNumber;
    }
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _addressLineOne.dispose();
    _addressLineTwo.dispose();
    _city.dispose();
    _zipCode.dispose();
    _contactNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("ADD NEW ADDRESS", context,
          automaticallyImplyLeading: true),
      body: BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
        listener: (context, state) {
          if (state is DeliveryInfoActionLoading) {
          } else if (state is DeliveryInfoAddActionSuccess) {
            context
                .read<DeliveryInfoFetchCubit>()
                .addDeliveryInfo(state.deliveryInfo);
            Navigator.of(context).pop();
          } else if (state is DeliveryInfoEditActionSuccess) {
            context
                .read<DeliveryInfoFetchCubit>()
                .editDeliveryInfo(state.deliveryInfo);
            Navigator.of(context).pop();
          } else if (state is DeliveryInfoActionFail) {}
        },
        child: Padding(
          padding: Space.all(1.2, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFieldTopText("First Name*"),
                  buildTextFormField(_firstName, 'First name'),
                  TextFieldTopText("Last name*"),
                  buildTextFormField(_lastName, 'Last name'),
                  TextFieldTopText("Line One*"),
                  buildTextFormField(_addressLineOne, 'Address line one'),
                  TextFieldTopText("Line Two*"),
                  buildTextFormField(_addressLineTwo, 'Address line two'),
                  TextFieldTopText("City*"),
                  buildTextFormField(_city, 'City'),
                  TextFieldTopText("Zip Code*"),
                  buildTextFormField(_zipCode, 'Zip code'),
                  TextFieldTopText("Contact number*"),
                  MobileNumberTextField(_contactNumber, 'Contact number'),
                  Space.yf(2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.deliveryInfo == null) {
                            context
                                .read<DeliveryInfoActionCubit>()
                                .addDeliveryInfo(DeliveryInfoModel(
                                  id: '',
                                  firstName: _firstName.text,
                                  lastName: _lastName.text,
                                  addressLineOne: _addressLineOne.text,
                                  addressLineTwo: _addressLineTwo.text,
                                  city: _city.text,
                                  zipCode: _zipCode.text,
                                  contactNumber: _contactNumber.text,
                                ));
                            context
                                .read<NotificationsCubit>()
                                .showAndSaveNotification("Addresses Update",
                                    "Congratulations, You have successfully updated your Address Book.");
                            // Phoenix.rebirth(context);
                            context
                                .read<DeliveryInfoFetchCubit>()
                                .fetchDeliveryInfo();
                            Navigator.pop(context);

                            Navigator.of(context)
                                .popAndPushNamed(AppRouter.addresses);
                          } else {
                            context
                                .read<DeliveryInfoActionCubit>()
                                .editDeliveryInfo(DeliveryInfoModel(
                                  id: id!,
                                  firstName: _firstName.text,
                                  lastName: _lastName.text,
                                  addressLineOne: _addressLineOne.text,
                                  addressLineTwo: _addressLineTwo.text,
                                  city: _city.text,
                                  zipCode: _zipCode.text,
                                  contactNumber: _contactNumber.text,
                                ));
                            context
                                .read<NotificationsCubit>()
                                .showAndSaveNotification("Addresses Update",
                                    "Congratulations, You have successfully updated your Address Book.");
                            // Phoenix.rebirth(context);
                            context
                                .read<DeliveryInfoFetchCubit>()
                                .fetchDeliveryInfo();
                            Navigator.pop(context);
                            //   Navigator.of(context).popAndPushNamed(AppRouter.addresses);
                          }
                        }
                      },
                      child: Text(
                        widget.deliveryInfo == null
                            ? 'Add Address'
                            : 'Edit Address',
                        style: AppText.h3b?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Space.yf(2)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
