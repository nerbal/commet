import 'package:commet/client/invitation.dart';
import 'package:commet/ui/atoms/room_panel.dart';
import 'package:commet/utils/common_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvitationDisplay extends StatefulWidget {
  const InvitationDisplay(this.invitation,
      {super.key, this.acceptInvitation, this.rejectInvitation});
  final Invitation invitation;
  final Future<void> Function(Invitation invite)? acceptInvitation;
  final Future<void> Function(Invitation invite)? rejectInvitation;

  @override
  State<InvitationDisplay> createState() => _InvitationDisplayState();
}

class _InvitationDisplayState extends State<InvitationDisplay> {
  String get labelHomeInvitationBody => Intl.message("Invited you to a room",
      name: "labelHomeInvitationBody",
      desc:
          "Displays a short description explaining that an invitation to a room was received. Does not need to contain the name of the room or inviter");

  bool acceptLoading = false;
  bool rejectLoading = false;

  @override
  Widget build(BuildContext context) {
    return RoomPanel(
      displayName: widget.invitation.displayName!,
      avatar: widget.invitation.avatar,
      recentEventSender: widget.invitation.senderId,
      color: widget.invitation.color,
      body: labelHomeInvitationBody,
      primaryButtonLabel: CommonStrings.promptAccept,
      onPrimaryButtonPressed: acceptInvitation,
      secondaryButtonLabel: CommonStrings.promptReject,
      onSecondaryButtonPressed: rejectInvitation,
      primaryButtonLoading: acceptLoading,
      secondaryButtonLoading: rejectLoading,
    );
  }

  Future<void> acceptInvitation() async {
    setState(() {
      acceptLoading = true;
    });

    await widget.acceptInvitation?.call(widget.invitation);

    setState(() {
      acceptLoading = false;
    });
  }

  Future<void> rejectInvitation() async {
    setState(() {
      rejectLoading = true;
    });

    await widget.rejectInvitation?.call(widget.invitation);

    setState(() {
      rejectLoading = false;
    });
  }
}
