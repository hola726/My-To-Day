// Mocks generated by Mockito 5.3.2 from annotations
// in my_to_day/test/mock/mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i4;

import 'package:flutter/foundation.dart' as _i3;
import 'package:flutter/rendering.dart' as _i6;
import 'package:flutter/services.dart' as _i7;
import 'package:flutter/src/widgets/editable_text.dart' as _i10;
import 'package:flutter/src/widgets/focus_manager.dart' as _i5;
import 'package:flutter/src/widgets/focus_traversal.dart' as _i9;
import 'package:flutter/src/widgets/framework.dart' as _i2;
import 'package:flutter/src/widgets/notification_listener.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWidget_0 extends _i1.SmartFake implements _i2.Widget {
  _FakeWidget_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_1 extends _i1.SmartFake
    implements _i2.InheritedWidget {
  _FakeInheritedWidget_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_2 extends _i1.SmartFake
    implements _i3.DiagnosticsNode {
  _FakeDiagnosticsNode_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({
    _i3.TextTreeConfiguration? parentConfiguration,
    _i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info,
  }) =>
      super.toString();
}

class _FakeSize_3 extends _i1.SmartFake implements _i4.Size {
  _FakeSize_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOffset_4 extends _i1.SmartFake implements _i4.Offset {
  _FakeOffset_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRect_5 extends _i1.SmartFake implements _i4.Rect {
  _FakeRect_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFocusAttachment_6 extends _i1.SmartFake
    implements _i5.FocusAttachment {
  _FakeFocusAttachment_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTextSelection_7 extends _i1.SmartFake implements _i6.TextSelection {
  _FakeTextSelection_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTextEditingValue_8 extends _i1.SmartFake
    implements _i7.TextEditingValue {
  _FakeTextEditingValue_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTextSpan_9 extends _i1.SmartFake implements _i6.TextSpan {
  _FakeTextSpan_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info}) =>
      super.toString();
}

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuildContext extends _i1.Mock implements _i2.BuildContext {
  MockBuildContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Widget get widget => (super.noSuchMethod(
        Invocation.getter(#widget),
        returnValue: _FakeWidget_0(
          this,
          Invocation.getter(#widget),
        ),
      ) as _i2.Widget);
  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);
  @override
  bool get debugDoingBuild => (super.noSuchMethod(
        Invocation.getter(#debugDoingBuild),
        returnValue: false,
      ) as bool);
  @override
  _i2.InheritedWidget dependOnInheritedElement(
    _i2.InheritedElement? ancestor, {
    Object? aspect,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #dependOnInheritedElement,
          [ancestor],
          {#aspect: aspect},
        ),
        returnValue: _FakeInheritedWidget_1(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
      ) as _i2.InheritedWidget);
  @override
  void visitAncestorElements(bool Function(_i2.Element)? visitor) =>
      super.noSuchMethod(
        Invocation.method(
          #visitAncestorElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void visitChildElements(_i2.ElementVisitor? visitor) => super.noSuchMethod(
        Invocation.method(
          #visitChildElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispatchNotification(_i8.Notification? notification) =>
      super.noSuchMethod(
        Invocation.method(
          #dispatchNotification,
          [notification],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.DiagnosticsNode describeElement(
    String? name, {
    _i3.DiagnosticsTreeStyle? style = _i3.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeElement,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeElement,
            [name],
            {#style: style},
          ),
        ),
      ) as _i3.DiagnosticsNode);
  @override
  _i3.DiagnosticsNode describeWidget(
    String? name, {
    _i3.DiagnosticsTreeStyle? style = _i3.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeWidget,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeWidget,
            [name],
            {#style: style},
          ),
        ),
      ) as _i3.DiagnosticsNode);
  @override
  List<_i3.DiagnosticsNode> describeMissingAncestor(
          {required Type? expectedAncestorType}) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeMissingAncestor,
          [],
          {#expectedAncestorType: expectedAncestorType},
        ),
        returnValue: <_i3.DiagnosticsNode>[],
      ) as List<_i3.DiagnosticsNode>);
  @override
  _i3.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeOwnershipChain,
          [name],
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeOwnershipChain,
            [name],
          ),
        ),
      ) as _i3.DiagnosticsNode);
}

/// A class which mocks [FocusNode].
///
/// See the documentation for Mockito's code generation for more information.
class MockFocusNode extends _i1.Mock implements _i5.FocusNode {
  MockFocusNode() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onKey(_i5.FocusOnKeyCallback? _onKey) => super.noSuchMethod(
        Invocation.setter(
          #onKey,
          _onKey,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set onKeyEvent(_i5.FocusOnKeyEventCallback? _onKeyEvent) =>
      super.noSuchMethod(
        Invocation.setter(
          #onKeyEvent,
          _onKeyEvent,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get skipTraversal => (super.noSuchMethod(
        Invocation.getter(#skipTraversal),
        returnValue: false,
      ) as bool);
  @override
  set skipTraversal(bool? value) => super.noSuchMethod(
        Invocation.setter(
          #skipTraversal,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get canRequestFocus => (super.noSuchMethod(
        Invocation.getter(#canRequestFocus),
        returnValue: false,
      ) as bool);
  @override
  set canRequestFocus(bool? value) => super.noSuchMethod(
        Invocation.setter(
          #canRequestFocus,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get descendantsAreFocusable => (super.noSuchMethod(
        Invocation.getter(#descendantsAreFocusable),
        returnValue: false,
      ) as bool);
  @override
  set descendantsAreFocusable(bool? value) => super.noSuchMethod(
        Invocation.setter(
          #descendantsAreFocusable,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get descendantsAreTraversable => (super.noSuchMethod(
        Invocation.getter(#descendantsAreTraversable),
        returnValue: false,
      ) as bool);
  @override
  set descendantsAreTraversable(bool? value) => super.noSuchMethod(
        Invocation.setter(
          #descendantsAreTraversable,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Iterable<_i5.FocusNode> get children => (super.noSuchMethod(
        Invocation.getter(#children),
        returnValue: <_i5.FocusNode>[],
      ) as Iterable<_i5.FocusNode>);
  @override
  Iterable<_i5.FocusNode> get traversalChildren => (super.noSuchMethod(
        Invocation.getter(#traversalChildren),
        returnValue: <_i5.FocusNode>[],
      ) as Iterable<_i5.FocusNode>);
  @override
  set debugLabel(String? value) => super.noSuchMethod(
        Invocation.setter(
          #debugLabel,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Iterable<_i5.FocusNode> get descendants => (super.noSuchMethod(
        Invocation.getter(#descendants),
        returnValue: <_i5.FocusNode>[],
      ) as Iterable<_i5.FocusNode>);
  @override
  Iterable<_i5.FocusNode> get traversalDescendants => (super.noSuchMethod(
        Invocation.getter(#traversalDescendants),
        returnValue: <_i5.FocusNode>[],
      ) as Iterable<_i5.FocusNode>);
  @override
  Iterable<_i5.FocusNode> get ancestors => (super.noSuchMethod(
        Invocation.getter(#ancestors),
        returnValue: <_i5.FocusNode>[],
      ) as Iterable<_i5.FocusNode>);
  @override
  bool get hasFocus => (super.noSuchMethod(
        Invocation.getter(#hasFocus),
        returnValue: false,
      ) as bool);
  @override
  bool get hasPrimaryFocus => (super.noSuchMethod(
        Invocation.getter(#hasPrimaryFocus),
        returnValue: false,
      ) as bool);
  @override
  _i5.FocusHighlightMode get highlightMode => (super.noSuchMethod(
        Invocation.getter(#highlightMode),
        returnValue: _i5.FocusHighlightMode.touch,
      ) as _i5.FocusHighlightMode);
  @override
  _i4.Size get size => (super.noSuchMethod(
        Invocation.getter(#size),
        returnValue: _FakeSize_3(
          this,
          Invocation.getter(#size),
        ),
      ) as _i4.Size);
  @override
  _i4.Offset get offset => (super.noSuchMethod(
        Invocation.getter(#offset),
        returnValue: _FakeOffset_4(
          this,
          Invocation.getter(#offset),
        ),
      ) as _i4.Offset);
  @override
  _i4.Rect get rect => (super.noSuchMethod(
        Invocation.getter(#rect),
        returnValue: _FakeRect_5(
          this,
          Invocation.getter(#rect),
        ),
      ) as _i4.Rect);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  void unfocus(
          {_i5.UnfocusDisposition? disposition =
              _i5.UnfocusDisposition.scope}) =>
      super.noSuchMethod(
        Invocation.method(
          #unfocus,
          [],
          {#disposition: disposition},
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool consumeKeyboardToken() => (super.noSuchMethod(
        Invocation.method(
          #consumeKeyboardToken,
          [],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i5.FocusAttachment attach(
    _i2.BuildContext? context, {
    _i5.FocusOnKeyEventCallback? onKeyEvent,
    _i5.FocusOnKeyCallback? onKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #attach,
          [context],
          {
            #onKeyEvent: onKeyEvent,
            #onKey: onKey,
          },
        ),
        returnValue: _FakeFocusAttachment_6(
          this,
          Invocation.method(
            #attach,
            [context],
            {
              #onKeyEvent: onKeyEvent,
              #onKey: onKey,
            },
          ),
        ),
      ) as _i5.FocusAttachment);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void requestFocus([_i5.FocusNode? node]) => super.noSuchMethod(
        Invocation.method(
          #requestFocus,
          [node],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool nextFocus() => (super.noSuchMethod(
        Invocation.method(
          #nextFocus,
          [],
        ),
        returnValue: false,
      ) as bool);
  @override
  bool previousFocus() => (super.noSuchMethod(
        Invocation.method(
          #previousFocus,
          [],
        ),
        returnValue: false,
      ) as bool);
  @override
  bool focusInDirection(_i9.TraversalDirection? direction) =>
      (super.noSuchMethod(
        Invocation.method(
          #focusInDirection,
          [direction],
        ),
        returnValue: false,
      ) as bool);
  @override
  void debugFillProperties(_i3.DiagnosticPropertiesBuilder? properties) =>
      super.noSuchMethod(
        Invocation.method(
          #debugFillProperties,
          [properties],
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i3.DiagnosticsNode> debugDescribeChildren() => (super.noSuchMethod(
        Invocation.method(
          #debugDescribeChildren,
          [],
        ),
        returnValue: <_i3.DiagnosticsNode>[],
      ) as List<_i3.DiagnosticsNode>);
  @override
  String toStringShort() => (super.noSuchMethod(
        Invocation.method(
          #toStringShort,
          [],
        ),
        returnValue: '',
      ) as String);
  @override
  String toString({_i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info}) =>
      super.toString();
  @override
  String toStringShallow({
    String? joiner = r', ',
    _i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.debug,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toStringShallow,
          [],
          {
            #joiner: joiner,
            #minLevel: minLevel,
          },
        ),
        returnValue: '',
      ) as String);
  @override
  String toStringDeep({
    String? prefixLineOne = r'',
    String? prefixOtherLines,
    _i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.debug,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toStringDeep,
          [],
          {
            #prefixLineOne: prefixLineOne,
            #prefixOtherLines: prefixOtherLines,
            #minLevel: minLevel,
          },
        ),
        returnValue: '',
      ) as String);
  @override
  _i3.DiagnosticsNode toDiagnosticsNode({
    String? name,
    _i3.DiagnosticsTreeStyle? style,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toDiagnosticsNode,
          [],
          {
            #name: name,
            #style: style,
          },
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #toDiagnosticsNode,
            [],
            {
              #name: name,
              #style: style,
            },
          ),
        ),
      ) as _i3.DiagnosticsNode);
  @override
  void addListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TextEditingController].
///
/// See the documentation for Mockito's code generation for more information.
class MockTextEditingController extends _i1.Mock
    implements _i10.TextEditingController {
  MockTextEditingController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get text => (super.noSuchMethod(
        Invocation.getter(#text),
        returnValue: '',
      ) as String);
  @override
  set text(String? newText) => super.noSuchMethod(
        Invocation.setter(
          #text,
          newText,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set value(_i7.TextEditingValue? newValue) => super.noSuchMethod(
        Invocation.setter(
          #value,
          newValue,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.TextSelection get selection => (super.noSuchMethod(
        Invocation.getter(#selection),
        returnValue: _FakeTextSelection_7(
          this,
          Invocation.getter(#selection),
        ),
      ) as _i6.TextSelection);
  @override
  set selection(_i6.TextSelection? newSelection) => super.noSuchMethod(
        Invocation.setter(
          #selection,
          newSelection,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.TextEditingValue get value => (super.noSuchMethod(
        Invocation.getter(#value),
        returnValue: _FakeTextEditingValue_8(
          this,
          Invocation.getter(#value),
        ),
      ) as _i7.TextEditingValue);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i6.TextSpan buildTextSpan({
    required _i2.BuildContext? context,
    _i6.TextStyle? style,
    required bool? withComposing,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #buildTextSpan,
          [],
          {
            #context: context,
            #style: style,
            #withComposing: withComposing,
          },
        ),
        returnValue: _FakeTextSpan_9(
          this,
          Invocation.method(
            #buildTextSpan,
            [],
            {
              #context: context,
              #style: style,
              #withComposing: withComposing,
            },
          ),
        ),
      ) as _i6.TextSpan);
  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void clearComposing() => super.noSuchMethod(
        Invocation.method(
          #clearComposing,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool isSelectionWithinTextBounds(_i6.TextSelection? selection) =>
      (super.noSuchMethod(
        Invocation.method(
          #isSelectionWithinTextBounds,
          [selection],
        ),
        returnValue: false,
      ) as bool);
  @override
  void addListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}